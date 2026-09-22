<?php
namespace App\Http\Controllers;
use App\Models\DemoLicenciaCase;
use App\Services\DemoLicenciaService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Carbon\Carbon;
class DemoCircuitController extends Controller {
 public function index(Request $r) {
  $role=$r->session()->get('demo_role','paciente');
  return view('demo.circuit',['reviewSettings'=>$role==='contraloria'?app(\App\Services\AutoReviewService::class)->settings():[],'role'=>$role,'cases'=>DemoLicenciaCase::latest('id')->get(),'patients'=>DB::table('demo_patients')->get(),'filterAudits'=>in_array($role,['admin','auditor','contraloria'])?DB::table('demo_filter_audits')->latest('id')->get():collect(),'logs'=>in_array($role,['admin','auditor','contraloria'])?DB::table('demo_workflow_audits')->latest('id')->limit(100)->get():collect()]);
 }
 public function prepare(Request $r,DemoLicenciaService $flow,DemoIntakeController $intake) {
  abort_unless(in_array($r->session()->get('demo_role','admin'),['admin','paciente','profesional']),403);
  $v=$r->validate(['patient_id'=>'required|exists:demo_patients,id']);
  $rel=DB::table('demo_care_relations')->where('patient_id',$v['patient_id'])->first();
  if(!$rel)throw ValidationException::withMessages(['patient_id'=>'Registra primero la relación del paciente, profesional y lugar en Inicio.']);
  return DB::transaction(function()use($r,$flow,$intake,$rel){
   $site=DB::table('demo_sites')->find($rel->site_id);$mode=$site->detail==='telematica'?'telematica':'presencial';$start=now()->startOfDay()->addHours(10);
   $r->merge(['id'=>null,'patient_id'=>$rel->patient_id,'professional_id'=>$rel->professional_id,'site_id'=>$rel->site_id,'appointment_at'=>$start->format('Y-m-d H:i:s'),'appointment_mode'=>$mode,'started_at'=>$start->format('Y-m-d H:i:s'),'ended_at'=>$start->copy()->addMinutes(20)->format('Y-m-d H:i:s'),'mode'=>$mode,'bono'=>'BONO-DEMO-'.uniqid(),'bono_verified'=>1,'professional_enabled'=>1,'decision'=>'con_licencia','diagnosis'=>'Diagnóstico ficticio para demostración','days'=>7,'start'=>$start->toDateString(),'insurance'=>'Fonasa','address'=>'Domicilio de reposo demo del paciente '.$rel->patient_id]);
   $r->session()->put('demo_role','profesional');$response=$intake->save($r,$flow);
   $case=DemoLicenciaCase::findOrFail((int)basename(parse_url($response->getTargetUrl(),PHP_URL_PATH)));
   $d=$case->data;$d['employer']='Empleador demo '.$rel->patient_id.' SpA';$d['circuit_demo']=true;$d['payer']='COMPIN / entidad pagadora demo (Fonasa sin CCAF)';$case->update(['data'=>$d]);
   foreach(['profesional','identidad','emitir'] as $a)$case=$flow->act($case,$a,'profesional',[],$case->version);
   $r->session()->put('demo_role','paciente');return redirect('/demo/circuito')->with('ok','Solicitud de ejemplo enviada a la bandeja del paciente.');
  });
 }
 public function action(Request $r,DemoLicenciaCase $case,DemoLicenciaService $flow) {
  try {return $this->dispatchAction($r,$case,$flow);}catch(ValidationException $e){
   if($r->input('action')==='antecedentes')DB::table('demo_workflow_audits')->insert(['folio'=>$case->folio,'action'=>'antecedentes','role'=>$r->session()->get('demo_role','admin'),'channel'=>'portal','result'=>'bloqueado','status'=>$case->fresh()->status,'reason'=>implode(' ',array_merge(...array_values($e->errors()))),'created_at'=>now(),'updated_at'=>now()]);
   throw $e;
  }
 }
 private function dispatchAction(Request $r,DemoLicenciaCase $case,DemoLicenciaService $flow) {
  $v=$r->validate(['action'=>'required|in:autorizar,no_autorizar,antecedentes,dictamen,pagar','version'=>'required|integer']);$role=$r->session()->get('demo_role','admin');
  $next=null;
  if(in_array($v['action'],['autorizar','no_autorizar','pagar'])){$case=$flow->act($case,$v['action'],$role,[],$v['version']);$next=$v['action']==='autorizar'?'empleador':$role;}
  elseif($v['action']==='antecedentes'){
   abort_unless($role==='empleador',403);
   DB::transaction(function()use($case,$flow,$v){$case=DemoLicenciaCase::whereKey($case->id)->lockForUpdate()->firstOrFail();
    if(!(bool)($case->data['consent']??false))throw ValidationException::withMessages(['action'=>'El paciente todavía no ha aprobado el envío.']);
    if($case->status!=='empleador')throw ValidationException::withMessages(['action'=>'El expediente ya no está en la etapa de documentación laboral. Estado actual: '.(DemoLicenciaService::STATES[$case->status]??$case->status).'.']);
    if($case->version!==(int)$v['version'])throw ValidationException::withMessages(['action'=>'El expediente cambió en otra ventana. Recarga la página antes de continuar.']);
    foreach(array_keys(DemoLicenciaService::DOCS) as $doc){if(!isset($case->data['documents'][$doc]))$case=$flow->act($case,'documento','empleador',['document'=>$doc],$case->version);}
    $d=$case->data;$d['payrolls']=[];foreach([3,2,1] as $m)$d['payrolls'][]=['period'=>Carbon::parse($d['start'])->startOfMonth()->subMonths($m)->format('Y-m'),'net'=>900000];$d['risk_evidence']=($d['risk_evidence']??[])+['contract_start'=>Carbon::parse($d['start'])->subYear()->toDateString(),'affiliation_start'=>Carbon::parse($d['start'])->subYear()->toDateString(),'employer_id'=>'EMP-DEMO-'.$case->id,'contract_net'=>900000,'previous_net'=>900000,'payroll_gross'=>1100000,'contribution_gross'=>1100000,'recipient_id'=>$d['rut'],'recipient_verified'=>true];$d['contribution_months']=6;$d['employment_verified_demo']=true;$d['prior_leave_statement']='Historial de licencias de seis meses incorporado al expediente demo';$case->update(['data'=>$d]);
    $flow->act($case,'enviar','empleador',['monthly_net'=>900000],$case->version);
   });$next='pagador';
  }else{
   abort_unless($role==='contraloria',403);$case=$flow->act($case,'dictamen','contraloria',['decision'=>'aprobada','note'=>'Resolución favorable simulada tras revisión de antecedentes del demo.'],$v['version']);$next='pagador';
  }
  $r->session()->put('demo_role',$next??$role);return redirect('/demo/circuito')->with('ok',$v['action']==='no_autorizar'?'Paciente rechaza: proceso detenido.':'Paso registrado y controlado en el backend.');
 }
}
