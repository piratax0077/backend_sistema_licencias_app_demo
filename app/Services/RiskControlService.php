<?php
namespace App\Services;
use App\Models\DemoLicenciaCase;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
class RiskControlService {
 public const RULES=[
 'appointments'=>'Consultas superpuestas o lugares incompatibles',
 'emission_rate'=>'Porcentaje atípico de consultas con licencia',
 'overlapping_leave'=>'Licencias con fechas superpuestas',
 'repeated_pair'=>'Repetición paciente–profesional',
 'salary'=>'Concordancia y aumentos de remuneraciones',
 'employment'=>'Concordancia del vínculo laboral',
 'documents'=>'Bono duplicado y alteración de antecedentes',
 'overrides'=>'Excepciones y cambios de dictamen',
 'payment'=>'Pago duplicado o destinatario inconsistente',
 'separation'=>'Separación de funciones por operador demo'];
 public const NUMBERS=[
 'window_days'=>['Período de análisis (días)',90,1,730],
 'travel_minutes'=>['Separación mínima entre lugares presenciales (min)',30,0,240],
 'min_consultations'=>['Muestra mínima para tasa de emisión',20,2,10000],
 'max_emission_pct'=>['Porcentaje de consultas con licencia',80,1,100],
 'rate_increase_pp'=>['Aumento de tasa frente al período anterior (puntos)',30,1,100],
 'pair_limit'=>['Licencias paciente–profesional: revisar desde',3,2,100],
 'salary_tolerance_pct'=>['Tolerancia entre remuneraciones (%)',5,0,100],
 'salary_increase_pct'=>['Aumento respecto del sueldo anterior (%)',30,1,300]];
 public function defaults():array{return ['risk_rules'=>array_fill_keys(array_keys(self::RULES),true)]+array_map(fn($v)=>$v[1],self::NUMBERS);}
 public static function digest(array $d):string{return hash('sha256',json_encode([$d['documents']??[],$d['payrolls']??[],$d['risk_evidence']??[]],JSON_UNESCAPED_UNICODE|JSON_PRESERVE_ZERO_FRACTION));}
 public function evaluate(DemoLicenciaCase $case,array $p):array {
  if(!config('demo.risk_checks',true))return [];
  $d=$case->data;$flags=[];$on=fn($key)=>!empty($p['risk_rules'][$key]);
  $add=function($code,$actor,$reason,$evidence=[],$severity='revision')use(&$flags){$flags[]=['code'=>$code,'actor'=>$actor,'reason'=>$reason,'evidence'=>$evidence,'severity'=>$severity];};
  $all=DemoLicenciaCase::whereNotIn('status',['borrador','cancelada'])->get();
  $start=Carbon::parse($d['start'])->startOfDay();$end=$start->copy()->addDays(max(1,$d['days'])-1)->endOfDay();$from=$start->copy()->subDays($p['window_days']);
  $consultation=isset($d['consultation_id'])?DB::table('demo_consultations')->find($d['consultation_id']):null;
  if($on('appointments')&&$consultation){
   foreach(DB::table('demo_consultations')->where('professional_id',$consultation->professional_id)->where('id','!=',$consultation->id)->get() as $other){
    $a=Carbon::parse($consultation->started_at);$b=Carbon::parse($consultation->ended_at);$c=Carbon::parse($other->started_at);$e=Carbon::parse($other->ended_at);
    if($a->lt($e)&&$c->lt($b))$add('appointments','Profesional','Consultas con horarios superpuestos.',['atenciones'=>[$consultation->id,$other->id],'inicio'=>$consultation->started_at,'otra_consulta'=>$other->started_at]);
    elseif($consultation->mode==='presencial'&&$other->mode==='presencial'&&$other->site_id!==$consultation->site_id){$gap=$a->gte($e)?$e->diffInMinutes($a):$b->diffInMinutes($c);if($gap<$p['travel_minutes'])$add('appointments','Profesional','Atenciones presenciales en lugares diferentes con escaso tiempo entre consultas.',['otra_atencion'=>$other->id,'minutos'=>$gap,'mínimo'=>$p['travel_minutes']]);}
   }
  }
  if($on('emission_rate')&&$consultation){
   $windowEnd=Carbon::parse($consultation->started_at)->endOfDay();$windowStart=$windowEnd->copy()->subDays($p['window_days']);
   $q=DB::table('demo_consultations')->where('professional_id',$consultation->professional_id);
   $recent=(clone $q)->whereBetween('started_at',[$windowStart,$windowEnd])->get();$past=(clone $q)->where('started_at','<',$windowStart)->where('started_at','>=',$windowStart->copy()->subDays($p['window_days']))->get();
   $countIssued=fn($rows)=>$rows->filter(fn($r)=>$r->case_id&&$all->contains('id',$r->case_id))->count();
   if($recent->count()>=$p['min_consultations']){$rate=100*$countIssued($recent)/$recent->count();$prior=$past->count()>=$p['min_consultations']?100*$countIssued($past)/$past->count():null;if($rate>$p['max_emission_pct']||($prior!==null&&$rate-$prior>$p['rate_increase_pp']))$add('emission_rate','Profesional','Tasa de emisión atípica: requiere revisar contexto y especialidad.',['consultas'=>$recent->count(),'porcentaje'=>round($rate,1),'porcentaje_anterior'=>$prior,'especialidad'=>$d['specialty']??'Sin registrar']);}
  }
  if($on('overlapping_leave'))foreach($all as $other){if($other->id===$case->id||$other->data['rut']!==$d['rut'])continue;$o=$other->data;$os=Carbon::parse($o['start']);$oe=$os->copy()->addDays(max(1,$o['days'])-1)->endOfDay();if($start->lte($oe)&&$os->lte($end)){
   $exception=($d['related_case_id']??null)==$other->id&&in_array($d['leave_relation']??'',['continuacion','reemplazo','varios_empleadores'])&&mb_strlen($d['relation_explanation']??'')>=10;
   if(!$exception)$add('overlapping_leave','Paciente','Reposos superpuestos: aclarar continuidad, reemplazo o múltiples empleadores.',['otro_folio'=>$other->folio,'inicio'=>$o['start'],'dias'=>$o['days']]);
  }}
  if($on('repeated_pair')){$pair=$all->filter(fn($c)=>$c->data['rut']===$d['rut']&&$c->data['doctor']===$d['doctor']&&Carbon::parse($c->data['start'])->betweenIncluded($from,$end));if($pair->count()>=$p['pair_limit'])$add('repeated_pair','Paciente / profesional','Repetición paciente–profesional en el período configurado.',['cantidad'=>$pair->count(),'periodo_dias'=>$p['window_days'],'folios'=>$pair->pluck('folio')->values()->all()]);}
  $financial=in_array($case->status,['revision','aprobada','reducida','apelacion','pagada']);$e=$d['risk_evidence']??[];
  if($on('salary')&&$financial){
   $payrolls=$d['payrolls']??[];
   if(count($payrolls)!==3||!isset($e['contract_net'],$e['previous_net'],$e['payroll_gross'],$e['contribution_gross']))$add('salary','Empleador','Faltan antecedentes comparables de remuneraciones; no se considera fraude probado.');
   else{$mean=collect($payrolls)->avg('net');$diff=fn($a,$b)=>100*abs($a-$b)/max(1,$b);
    if($diff($mean,$d['monthly_net'])>$p['salary_tolerance_pct']||$diff($mean,$e['contract_net'])>$p['salary_tolerance_pct']||$diff($e['payroll_gross'],$e['contribution_gross'])>$p['salary_tolerance_pct'])$add('salary','Empleador','Diferencias entre liquidaciones, promedio declarado, contrato o bases imponibles.',['neto_liquidaciones'=>$mean,'neto_declarado'=>$d['monthly_net'],'neto_contrato'=>$e['contract_net'],'imponible_liquidaciones'=>$e['payroll_gross'],'imponible_cotizaciones'=>$e['contribution_gross']]);
    if($mean>$e['previous_net']*(1+$p['salary_increase_pct']/100))$add('salary','Empleador','Aumento de remuneraciones previo al reposo que requiere respaldo.',['neto_anterior'=>$e['previous_net'],'neto_actual'=>$mean]);
   }
  }
  if($on('employment')&&$financial){if(empty($e['contract_start'])||empty($e['affiliation_start'])||empty($e['employer_id']))$add('employment','Empleador','Vínculo laboral sin fechas o identificador verificables en el demo.');else{if(Carbon::parse($e['contract_start'])->gt($start)||Carbon::parse($e['affiliation_start'])->gt($start))$add('employment','Empleador','Contrato o afiliación comienza después del inicio del reposo.',['contrato'=>$e['contract_start'],'afiliacion'=>$e['affiliation_start'],'reposo'=>$d['start']]);}}
  if($on('documents')){
   $duplicates=$all->filter(fn($c)=>$c->id!==$case->id&&trim(strtoupper($c->data['bono']??''))===trim(strtoupper($d['bono']??'')));
   if(!empty($d['bono'])&&$duplicates->isNotEmpty())$add('documents','Profesional / emisor','Bono ya asociado a otra licencia emitida.',['folios'=>$duplicates->pluck('folio')->all()],'bloqueo');
   if($financial && !empty($d['documents']) && !isset($d['documents_digest']))$add('documents','Empleador','Antecedentes anteriores sin huella de verificación; requieren revalidación.');
   if(isset($d['documents_digest'])&&!hash_equals($d['documents_digest'],self::digest($d)))$add('documents','Empleador','Los antecedentes cambiaron después del envío verificado. Requieren nueva validación.',['huella_original'=>$d['documents_digest'],'huella_actual'=>self::digest($d)]);
  }
  if($on('overrides')){
   $decisions=array_values(array_filter($d['events']??[],fn($event)=>str_contains($event['label']??'','Dictamen')||str_contains($event['label']??'','Auditoría cierra')));
   foreach($decisions as $event)if(mb_strlen(trim($event['note']??''))<10)$add('overrides','Contraloría','Dictamen o cierre de alerta sin fundamento suficiente.',['fecha'=>$event['at']]);
   if(count($d['decision_history']??[])>1)$add('overrides','Contraloría','El dictamen cambió; revisar antecedentes y fundamento de las decisiones.',['decisiones'=>$d['decision_history']]);
  }
  if($on('payment')&&$financial){if(empty($e['recipient_id'])||empty($e['recipient_verified']))$add('payment','Entidad pagadora','Destinatario del pago pendiente de verificación.');elseif($e['recipient_id']!==$d['rut'])$add('payment','Entidad pagadora','Destinatario distinto del paciente: requiere respaldo de representación o convenio.',['paciente'=>$d['rut'],'destinatario'=>$e['recipient_id']]);
   if($case->status!=='pagada'&&DB::table('demo_payment_claims')->where('folio',$case->folio)->exists())$add('payment','Entidad pagadora','Ya existe un pago registrado para este folio.',[],'bloqueo');
  }
  if($on('separation')){if($financial && empty($d['workflow_actors']['emitir']))$add('separation','Operadores','Emisión anterior sin identificador de operador verificable en el demo.');$actors=$d['workflow_actors']??[];$seen=[];foreach(['emitir','dictamen','pagar'] as $action){if(empty($actors[$action]))continue;$actor=$actors[$action];if(isset($seen[$actor]))$add('separation','Operadores','El mismo operador interviene en funciones incompatibles.',['operador'=>$actor,'acciones'=>[$seen[$actor],$action]],'bloqueo');$seen[$actor]=$action;}}
  return $flags;
 }
 public function claimBono(DemoLicenciaCase $case):void {
  $bono=trim(strtoupper($case->data['bono']??''));if($bono==='')return;
  $duplicate=DemoLicenciaCase::whereKeyNot($case->id)->whereNotIn('status',['borrador','cancelada'])->get()->contains(fn($c)=>trim(strtoupper($c->data['bono']??''))===$bono);
  if($duplicate)throw ValidationException::withMessages(['control'=>'Bono duplicado: ya pertenece a otra licencia emitida.']);
  DB::table('demo_bono_claims')->insertOrIgnore(['bono'=>$bono,'case_id'=>$case->id,'created_at'=>now()]);
  if(DB::table('demo_bono_claims')->where('bono',$bono)->value('case_id')!=$case->id)throw ValidationException::withMessages(['control'=>'Bono reservado por otra licencia; emisión bloqueada.']);
 }
 public function claimPayment(DemoLicenciaCase $case):void {
  if(!DB::table('demo_payment_claims')->insertOrIgnore(['folio'=>$case->folio,'case_id'=>$case->id,'created_at'=>now()]))throw ValidationException::withMessages(['control'=>'Pago duplicado bloqueado para este folio.']);
 }
}
