<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use App\Models\DemoLicenciaCase;
use App\Services\DemoLicenciaService;
use Carbon\Carbon;

class DemoIntakeController extends Controller {
 public function index(Request $r) { if(!$r->integer('edit') && in_array($r->session()->get('demo_role','admin'),['paciente','empleador','pagador','contraloria','auditor']))return app(DemoCircuitController::class)->index($r); if($r->integer('edit')) $this->allowed($r);
  $lists=[];foreach(['patients','professionals','sites'] as $type) $lists[$type]=DB::table('demo_'.$type)->orderBy('name')->get();
  $professionalSites=DB::table('demo_professional_sites')->get()->groupBy('professional_id')->map(fn($rows)=>$rows->pluck('site_id')->map(fn($id)=>(int)$id)->values());
  return view('demo.intake',compact('lists','professionalSites')+['relations'=>DB::table('demo_care_relations')->select('patient_id','professional_id','site_id')->union(DB::table('demo_consultations')->select('patient_id','professional_id','site_id'))->get()]+['audits'=>in_array($r->session()->get('demo_role','admin'),['admin','contraloria','auditor'])?DB::table('demo_filter_audits')->latest('id')->get():collect(),'consultations'=>DB::table('demo_consultations')->latest('id')->get(),'cases'=>DemoLicenciaCase::latest('id')->get(),'role'=>$r->session()->get('demo_role','admin'),'editing'=>$r->integer('edit')?DB::table('demo_consultations')->find($r->integer('edit')):null]);
 }
 private function allowed(Request $r): void {abort_unless(in_array($r->session()->get('demo_role','admin'),['admin','profesional']),403);}
 public function saveRelation(Request $r) {
  $this->allowed($r);
  $v=$r->validate(['patient_id'=>'required|exists:demo_patients,id','professional_id'=>'required|exists:demo_professionals,id','site_id'=>'required|exists:demo_sites,id']);
  $configuredSites=DB::table('demo_professional_sites')->where('professional_id',$v['professional_id']);
  if((clone $configuredSites)->exists()&&!(clone $configuredSites)->where('site_id',$v['site_id'])->exists())throw ValidationException::withMessages(['site_id'=>'El lugar seleccionado no pertenece al profesional en Med-SDI.']);
  DB::table('demo_care_relations')->updateOrInsert($v,['updated_at'=>now(),'created_at'=>now()]);
  return redirect('/')->with('ok','Relación paciente, profesional y lugar guardada. Ya puedes continuar desde el perfil Paciente.');
 }
 public function save(Request $r,DemoLicenciaService $flow) {
  $this->allowed($r);
  $v=$r->validate(['id'=>'nullable|integer','patient_id'=>'required|exists:demo_patients,id','professional_id'=>'required|exists:demo_professionals,id','site_id'=>'required|exists:demo_sites,id','appointment_at'=>'nullable|date','appointment_mode'=>'nullable|in:presencial,telematica','started_at'=>'required|date','ended_at'=>'required|date|after:started_at','mode'=>'required|in:presencial,telematica','bono'=>'nullable|string|max:150','professional_enabled'=>'nullable|boolean','bono_verified'=>'nullable|boolean','decision'=>'required|in:sin_licencia,con_licencia','diagnosis'=>'required|string|max:500','days'=>'nullable|required_if:decision,con_licencia|integer|min:1|max:60','start'=>'nullable|required_if:decision,con_licencia|date_format:Y-m-d','insurance'=>'required|in:Fonasa,Isapre','address'=>'required|string|max:200']);
  $configuredSites=DB::table('demo_professional_sites')->where('professional_id',$v['professional_id']);
  if((clone $configuredSites)->exists()&&!(clone $configuredSites)->where('site_id',$v['site_id'])->exists())throw ValidationException::withMessages(['site_id'=>'El lugar seleccionado no pertenece al profesional en Med-SDI.']);
  return DB::transaction(function()use($v,$flow,$r){
   $id=$v['id']??null;unset($v['id']);$old=$id?DB::table('demo_consultations')->where('id',$id)->lockForUpdate()->first():null; if($id)abort_unless($old,404);
   if($old&&$old->case_id){$existing=DemoLicenciaCase::whereKey($old->case_id)->lockForUpdate()->first();if($existing&&$existing->status!=='borrador')throw ValidationException::withMessages(['id'=>'La licencia ya fue emitida. Su atención de origen queda conservada; puedes eliminar el recorrido completo desde el inicio.']);}
   foreach(['started_at','ended_at','appointment_at'] as $f)$v[$f]=empty($v[$f])?null:Carbon::parse($v[$f])->format('Y-m-d H:i:s');
   $v['professional_enabled']=(bool)($v['professional_enabled']??false);$v['bono_verified']=(bool)($v['bono_verified']??false);$v['updated_at']=now();
   DB::table('demo_care_relations')->updateOrInsert(['patient_id'=>$v['patient_id'],'professional_id'=>$v['professional_id'],'site_id'=>$v['site_id']],['updated_at'=>now(),'created_at'=>now()]);
   if($id)DB::table('demo_consultations')->where('id',$id)->update($v);else $id=DB::table('demo_consultations')->insertGetId($v+['created_at'=>now()]);
   if($v['decision']==='sin_licencia'){if($old&&$old->case_id)DemoLicenciaCase::whereKey($old->case_id)->delete();return redirect('/')->with('ok','Atención registrada sin licencia de reposo.');}
   $p=DB::table('demo_patients')->find($v['patient_id']);$doctor=DB::table('demo_professionals')->find($v['professional_id']);$site=DB::table('demo_sites')->find($v['site_id']);
   $date=Carbon::parse($v['started_at']);$q=DB::table('demo_consultations')->where('professional_id',$v['professional_id']);
   $daily=(clone $q)->whereDate('started_at',$date->toDateString());
   $issued=(clone $q)->join('demo_licencia_cases','demo_licencia_cases.id','=','demo_consultations.case_id')->where('demo_licencia_cases.status','!=','borrador');
   $snapshot=[
    'Relación paciente–profesional–lugar'=>$p->name.' / '.$doctor->name.' / '.$site->name,
    '1. Hora tomada para esta relación'=>$v['appointment_at']?:'Sin hora registrada',
    '2. QR o bono verificado'=>($v['bono_verified']&&$v['bono'])?'Verificado en demo: '.$v['bono']:'Pendiente de verificación',
    '3. Minutos de consulta'=>(int)Carbon::parse($v['started_at'])->diffInMinutes(Carbon::parse($v['ended_at'])),
    '4. Pacientes / consultas / licencias emitidas del profesional en el día'=>(clone $daily)->distinct()->count('patient_id').' / '.(clone $daily)->count().' / '.(clone $issued)->whereDate('demo_consultations.started_at',$date->toDateString())->count(),
    '5. Licencias emitidas del profesional en el mes'=>(clone $issued)->whereBetween('demo_consultations.started_at',[$date->copy()->startOfMonth(),$date->copy()->endOfMonth()])->count(),
    '6. Licencias emitidas de este paciente con el profesional'=>(clone $issued)->where('patient_id',$v['patient_id'])->count(),
    '7. Modalidad de atención / hora / lugar'=>$v['mode'].' / '.($v['appointment_mode']??'sin registrar').' / '.$site->detail,
   ];
   $case=isset($existing)&&$existing?$existing:$flow->create(['patient'=>$p->name,'rut'=>$p->detail,'address'=>$v['address'],'insurance'=>$v['insurance'],'days'=>$v['days'],'start'=>$v['start'],'diagnosis'=>$v['diagnosis']]);
   $data=$case->data;$data['doctor']=$doctor->name;$data['specialty']=$doctor->detail;$data['employer']='Por registrar';$data['consultation_id']=$id;$data['first_filter']=$snapshot;
   $snapshot['8. Profesional habilitado en Chile para emitir licencias']=$v['professional_enabled']?'Confirmado en simulación; sin consulta oficial':'No confirmado';
   $reasons=[];if(!$v['professional_enabled'])$reasons[]='No está confirmada la habilitación del profesional en Chile para emitir licencias médicas.';
   if(!$v['appointment_at'])$reasons[]='No existe hora tomada para la relación paciente, profesional y lugar.';
   if(!$v['bono']||!$v['bono_verified'])$reasons[]='Falta un QR o bono de atención verificado.';
   if($v['appointment_mode']!==$v['mode']||!in_array($site->detail,[$v['mode'],'mixta']))$reasons[]='La modalidad de consulta no concuerda con la hora o el lugar de atención.';
   $data['first_filter_passed']=count($reasons)===0;$data['first_filter_reasons']=$reasons;
   $data['patient']=$p->name;$data['rut']=$p->detail;foreach(['address','insurance','days','start','diagnosis'] as $field)$data[$field]=$v[$field];
   $data['verified_doctor']=false;$data['identity']=false;
   $message=$reasons?'Tu solicitud de licencia no superó el primer filtro de control y no ha sido emitida. '.implode(' ',$reasons).' Se dejó un aviso para Contraloría. Contacta al profesional para corregir los antecedentes.':null;
   $data['filter_notification']=$message;
   $data['events'][]=['at'=>now()->timezone('America/Santiago')->format('d-m-Y H:i:s'),'role'=>'Control inicial','source'=>'Portal web','label'=>$reasons?'Primer filtro no superado: aviso a Contraloría y notificación al paciente':'Primer filtro superado: registrado para Contraloría','note'=>$message??'Controles de origen completos. Continúa la verificación profesional y la emisión.'];
   $data['bono']=$v['bono']??'';$data['verified_bono']=$v['bono_verified']&&!!$v['bono'];$case->update(['data'=>$data,'version'=>$case->version+1]);DB::table('demo_consultations')->where('id',$id)->update(['case_id'=>$case->id]);
   DB::table('demo_filter_audits')->insert(['case_id'=>$case->id,'folio'=>$case->folio,'patient'=>$p->name,'passed'=>$data['first_filter_passed'],'snapshot'=>json_encode($snapshot,JSON_UNESCAPED_UNICODE),'reasons'=>json_encode($reasons,JSON_UNESCAPED_UNICODE),'patient_notification'=>$message,'created_at'=>now(),'updated_at'=>now()]);
   $r->session()->put('demo_role','profesional');return redirect()->route('demo.show',$case)->with('ok','Atención y primer filtro registrados. Revisa los controles antes de emitir.');
  });
 }
 public function remove(Request $r,int $id) {
  $this->allowed($r);return DB::transaction(function()use($id){$row=DB::table('demo_consultations')->where('id',$id)->lockForUpdate()->first();abort_unless($row,404);DB::table('demo_consultations')->where('id',$id)->delete();if($row->case_id)DemoLicenciaCase::whereKey($row->case_id)->delete();return redirect('/')->with('ok','Atención y expediente asociado eliminados.');});
 }
 public function review(Request $r,int $id) {
  abort_unless(in_array($r->session()->get('demo_role','admin'),['contraloria','auditor']),403);
  $v=$r->validate(['note'=>'required|string|max:1000']);
  $changed=DB::table('demo_filter_audits')->where('id',$id)->whereNull('reviewed_at')->update(['reviewed_at'=>now(),'review_note'=>$v['note'],'updated_at'=>now()]);
  return redirect('/#auditoria')->with('ok',$changed?'Aviso revisado y observación registrada. La revisión no omite los controles de emisión.':'El aviso ya había sido revisado.');
 }
 public function report(Request $r,int $id) {
  $c=DB::table('demo_consultations')->find($id);abort_unless($c,404);
  $related=DB::table('demo_consultations')->where('patient_id',$c->patient_id)->where('professional_id',$c->professional_id);
  $issued=(clone $related)->join('demo_licencia_cases','demo_licencia_cases.id','=','demo_consultations.case_id')->where('status','!=','borrador')->count();
  return view('demo.attention-report',['c'=>$c,'patient'=>DB::table('demo_patients')->find($c->patient_id),'professional'=>DB::table('demo_professionals')->find($c->professional_id),'site'=>DB::table('demo_sites')->find($c->site_id),'count'=>$related->count(),'issued'=>$issued,'case'=>$c->case_id?DemoLicenciaCase::find($c->case_id):null,'audits'=>$c->case_id&&in_array($r->session()->get('demo_role','admin'),['admin','contraloria','auditor'])?DB::table('demo_filter_audits')->where('case_id',$c->case_id)->get():collect(),'print'=>$r->boolean('imprimir')]);
 }
}
