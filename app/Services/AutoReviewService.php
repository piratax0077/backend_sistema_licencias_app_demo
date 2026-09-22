<?php
namespace App\Services;
use App\Models\DemoLicenciaCase;
use Illuminate\Support\Facades\DB;
class AutoReviewService {
 public function settings():array {$stored=json_decode(DB::table('demo_review_settings')->where('id',1)->value('data'),true);return array_replace_recursive(app(RiskControlService::class)->defaults(),$stored);}
 public function evaluate(DemoLicenciaCase $case):array {
  $p=$this->settings();$d=$case->data;$reasons=[];$distance=null;
  $number=DemoLicenciaCase::where('data->rut',$d['rut'])->where('id','<=',$case->id)->whereNotIn('status',['borrador','cancelada'])->count();
  if($p['review_from']>0 && $number>=$p['review_from'])$reasons[]='Licencia número '.$number.' del paciente (revisar desde '.$p['review_from'].').';
  if($d['days']>$p['max_days'])$reasons[]='Reposo de '.$d['days'].' días: supera '.$p['max_days'].'.';
  if($p['check_origin'] && !($d['first_filter_passed']??false))$reasons[]='Primer filtro de origen incompleto o no superado.';
  $consultation=isset($d['consultation_id'])?DB::table('demo_consultations')->find($d['consultation_id']):null;
  if($p['min_minutes']>0){$minutes=$consultation?\Carbon\Carbon::parse($consultation->started_at)->diffInMinutes(\Carbon\Carbon::parse($consultation->ended_at)):null;if($minutes===null||$minutes<$p['min_minutes'])$reasons[]='Duración de consulta insuficiente o sin datos; mínimo '.$p['min_minutes'].' minutos.';}
  if($p['check_location']){
   $location=collect($d['controls'])->filter(fn($c)=>($c['capture_type']??'')==='geolocation')->last();$ref=$d['rest_coordinates']??null;
   if(!$location||!$ref)$reasons[]='Falta ubicación autorizada o coordenadas del lugar de reposo; no se puede verificar el radio.';
   else{$lat1=deg2rad($ref['latitude']);$lat2=deg2rad($location['latitude']);$dl=deg2rad($location['longitude']-$ref['longitude']);$a=sin(($lat2-$lat1)/2)**2+cos($lat1)*cos($lat2)*sin($dl/2)**2;$distance=6371*2*asin(min(1,sqrt($a)));
    if($location['accuracy']>$p['max_accuracy'])$reasons[]='Precisión de ubicación insuficiente: '.$location['accuracy'].' m.';
    if($distance>$p['radius_km'])$reasons[]='Ubicación a '.round($distance,2).' km; radio permitido '.$p['radius_km'].' km.';
   }
  }
  $flags=app(RiskControlService::class)->evaluate($case,$p);foreach($flags as $flag)$reasons[]=$flag['reason'];
  return ['checks'=>$flags,'reasons'=>$reasons,'requires_review'=>collect($flags)->contains('severity','bloqueo') || count($reasons)>0 && ($d['manual_review_signature']??null)!==hash('sha256',json_encode([$p,$reasons,$flags])),'distance_km'=>$distance,'license_number'=>$number,'parameters'=>$p,'evaluated_at'=>now()->toIso8601String()];
 }
 public function refresh(DemoLicenciaCase $case):DemoLicenciaCase {
  return DB::transaction(function()use($case){$case=DemoLicenciaCase::whereKey($case->id)->lockForUpdate()->firstOrFail();if(in_array($case->status,['borrador','paciente','cancelada','rechazada','pagada']))return $case;
   $result=$this->evaluate($case);$d=$case->data;
   $same=isset($d['auto_review']) && $d['auto_review']['reasons']===$result['reasons'] && $d['auto_review']['parameters']===$result['parameters'] && ($d['auto_review']['checks']??[])===$result['checks'] && $d['auto_review']['requires_review']===$result['requires_review'];
   $d['auto_review']=$result;$status=$case->status;
   if($result['requires_review'] && in_array($status,['aprobada','reducida']))$status='revision';
   if($status==='revision'&&!$result['requires_review']&&!$d['hold']&&$d['consent']&&count($d['documents'])===count(DemoLicenciaService::DOCS)){
    $status='aprobada';$d['approved_days']=$d['days'];$d['resolution']='Validación automática del demo: parámetros configurados cumplidos. Sin pronunciamiento oficial.';
   }
   if(!$same||$status!==$case->status){$d['events'][]=['at'=>now()->toIso8601String(),'role'=>'Contraloría automática','source'=>'Backend','label'=>$result['requires_review']?'Derivado a revisión por parámetros':'Parámetros configurados cumplidos','note'=>implode(' ',$result['reasons'])];DB::table('demo_workflow_audits')->insert(['folio'=>$case->folio,'action'=>'evaluar_parametros','role'=>'sistema','channel'=>'backend','result'=>$result['requires_review']?'revision':'cumple','status'=>$status,'reason'=>json_encode($result,JSON_UNESCAPED_UNICODE),'created_at'=>now(),'updated_at'=>now()]);$case->update(['status'=>$status,'data'=>$d,'version'=>$case->version+1]);}
   return $case;
  });
 }
}
