<?php
namespace Tests\Feature;
use Tests\TestCase;
use App\Models\DemoLicenciaCase;
use App\Services\DemoLicenciaService;
use App\Services\RiskControlService;
use App\Services\AutoReviewService;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
class DemoRiskControlsTest extends TestCase {
 protected function setUp():void {parent::setUp();config(['database.default'=>'sqlite','database.connections.sqlite.database'=>':memory:','demo.automatic_review'=>false,'demo.risk_checks'=>true]);DB::purge('sqlite');foreach(glob(database_path('migrations/2026_09_*.php')) as $m)(require $m)->up();}
 private function makeCase(array $changes=[]):DemoLicenciaCase {
  $c=app(DemoLicenciaService::class)->create(['rut'=>'DEMO-'.(DemoLicenciaCase::count()+1),'start'=>'2026-09-01','days'=>7]);$d=$c->data;
  $d['consent']=true;$d['verified_bono']=true;$d['verified_doctor']=true;$d['identity']=true;$d['first_filter_passed']=true;$d['documents']=array_fill_keys(array_keys(DemoLicenciaService::DOCS),['name'=>'Documento ficticio']);$d['approved_days']=7;
  $d['payrolls']=[['period'=>'2026-06','net'=>900000],['period'=>'2026-07','net'=>900000],['period'=>'2026-08','net'=>900000]];
  $d['risk_evidence']=['contract_start'=>'2025-01-01','affiliation_start'=>'2025-01-01','employer_id'=>'EMP-DEMO','contract_net'=>900000,'previous_net'=>900000,'payroll_gross'=>1100000,'contribution_gross'=>1100000,'recipient_id'=>$d['rut'],'recipient_verified'=>true];$d['workflow_actors']=['emitir'=>'profesional-demo'];$d['documents_digest']=RiskControlService::digest($d);$c->update(['data'=>array_replace($d,$changes),'status'=>'revision']);return $c;
 }
 private function codes($c,$settings=[]):array {$p=array_replace(app(AutoReviewService::class)->settings(),$settings);return array_column(app(RiskControlService::class)->evaluate($c,$p),'code');}
 public function test_clean_case_and_salary_employment_recipient_anomalies():void {
  $c=$this->makeCase();$this->assertSame([],$this->codes($c));$d=$c->data;$d['risk_evidence']['contract_net']=300000;$d['risk_evidence']['previous_net']=300000;$d['risk_evidence']['contract_start']='2026-10-01';$d['risk_evidence']['recipient_id']='OTRO';$c->update(['data'=>$d]);$codes=$this->codes($c);foreach(['salary','employment','payment'] as $code)$this->assertContains($code,$codes);
  $p=app(AutoReviewService::class)->settings();$p['risk_rules']=array_fill_keys(array_keys(RiskControlService::RULES),false);$this->assertSame([],$this->codes($c,$p));
 }
 public function test_overlapping_and_repeated_leave_with_explicit_exception():void {
  $a=$this->makeCase();$b=$this->makeCase(['rut'=>$a->data['rut']]);$codes=$this->codes($b,['pair_limit'=>2]);$this->assertContains('overlapping_leave',$codes);$this->assertContains('repeated_pair',$codes);
  $d=$b->data;$d['leave_relation']='reemplazo';$d['related_case_id']=$a->id;$d['relation_explanation']='Reemplazo identificado y fundamentado.';$b->update(['data'=>$d]);$this->assertNotContains('overlapping_leave',$this->codes($b));
 }
 public function test_consultation_overlap_travel_gap_and_emission_rate():void {
  foreach(['patients','professionals','sites'] as $type)DB::table('demo_'.$type)->insert(['id'=>1,'name'=>'Demo','detail'=>'Demo']);DB::table('demo_sites')->insert(['id'=>2,'name'=>'Otro lugar','detail'=>'presencial']);
  $a=$this->makeCase();$b=$this->makeCase();
  foreach([[$a,1,'10:00','10:20'],[$b,2,'10:10','10:30']] as [$c,$id,$start,$end]){$consult=DB::table('demo_consultations')->insertGetId(['patient_id'=>1,'professional_id'=>1,'site_id'=>$id,'started_at'=>'2026-09-01 '.$start,'ended_at'=>'2026-09-01 '.$end,'mode'=>'presencial','decision'=>'con_licencia','diagnosis'=>'Demo','insurance'=>'Fonasa','address'=>'Demo','case_id'=>$c->id]);$d=$c->data;$d['consultation_id']=$consult;$c->update(['data'=>$d]);}
  $codes=$this->codes($b,['min_consultations'=>2,'max_emission_pct'=>80]);$this->assertContains('appointments',$codes);$this->assertContains('emission_rate',$codes);
  DB::table('demo_consultations')->where('case_id',$b->id)->update(['started_at'=>'2026-09-01 10:25','ended_at'=>'2026-09-01 10:45']);$this->assertContains('appointments',$this->codes($b));
 }
 public function test_duplicate_bono_is_blocked_atomically():void {
  $a=$this->makeCase();$b=$this->makeCase(['bono'=>$a->data['bono']]);$b->update(['status'=>'borrador']);
  try{app(DemoLicenciaService::class)->act($b,'emitir','profesional',[],$b->version);$this->fail('Debe bloquear bono repetido');}catch(ValidationException $e){$this->assertStringContainsString('Bono duplicado',$e->getMessage());}
  $this->assertSame('borrador',$b->fresh()->status);$this->assertDatabaseHas('demo_workflow_audits',['folio'=>$b->folio,'result'=>'bloqueado']);
 }
 public function test_document_tampering_and_unjustified_decision_are_observed():void {
  $c=$this->makeCase();$d=$c->data;$d['documents_digest']=RiskControlService::digest($d);$d['documents']['contrato']['name']='Contrato cambiado';$d['events'][]=['label'=>'Dictamen simulado','note'=>'','at'=>'2026-09-01'];$c->update(['data'=>$d]);$codes=$this->codes($c);$this->assertContains('documents',$codes);$this->assertContains('overrides',$codes);
  $this->withSession(['demo_role'=>'contraloria'])->post('/demo/riesgos/'.$c->id.'/revalidar',['version'=>$c->version,'note'=>'Se revisó y respaldó la nueva versión del contrato.'])->assertRedirect();$this->assertNotContains('documents',$this->codes($c->fresh()));
 }
 public function test_separation_and_duplicate_payment_prevent_operations():void {
  $c=$this->makeCase(['workflow_actors'=>['emitir'=>'operador-1']]);$c->update(['status'=>'aprobada']);$this->withSession(['demo_operator_id'=>'operador-1']);
  try{app(DemoLicenciaService::class)->act($c,'pagar','pagador',[],$c->version);$this->fail('Debe impedir misma cuenta');}catch(ValidationException $e){$this->assertStringContainsString('Separación',$e->getMessage());}
  $this->withSession(['demo_operator_id'=>'pagador-2']);$c=app(DemoLicenciaService::class)->act($c,'pagar','pagador',[],$c->version);$this->assertDatabaseCount('demo_payment_claims',1);
  $c->update(['status'=>'aprobada']);try{app(DemoLicenciaService::class)->act($c,'pagar','pagador',[],$c->version);$this->fail('Debe impedir segundo pago');}catch(ValidationException $e){$this->assertStringContainsString('Pago duplicado',$e->getMessage());}$this->assertDatabaseCount('demo_payment_claims',1);
 }
 public function test_settings_and_patient_explanation_are_saved_with_audit():void {
  $c=$this->makeCase();$p=app(AutoReviewService::class)->settings();$p['pair_limit']=5;
  $this->withSession(['demo_role'=>'contraloria'])->post('/demo/contraloria/parametros',$p)->assertRedirect('/');$this->assertEquals(5,app(AutoReviewService::class)->settings()['pair_limit']);$this->get('/')->assertOk()->assertSee('Controles cruzados por actor');
  $this->withSession(['demo_role'=>'paciente'])->post('/demo/riesgos/'.$c->id.'/explicacion',['note'=>'Salí del domicilio para una consulta médica.'])->assertRedirect();$this->assertSame('paciente',$c->fresh()->data['risk_explanations'][0]['role']);$this->assertDatabaseHas('demo_workflow_audits',['action'=>'explicar_control']);
 }
 public function test_all_rules_integrate_with_automatic_approval_and_payment():void {
  $c=$this->makeCase();$p=app(AutoReviewService::class)->settings();$p['check_location']=false;$p['min_minutes']=0;$p['review_from']=0;
  DB::table('demo_review_settings')->where('id',1)->update(['data'=>json_encode($p)]);config(['demo.automatic_review'=>true]);
  $c=app(AutoReviewService::class)->refresh($c);$this->assertSame('aprobada',$c->status);$this->assertEmpty($c->data['auto_review']['checks']);
  $c=app(DemoLicenciaService::class)->act($c,'pagar','pagador',[],$c->version);$this->assertSame('pagada',$c->status);$this->assertDatabaseCount('demo_payment_claims',1);
 }
 public function test_confirmed_block_cannot_be_waived_and_explanation_from_app_is_recorded():void {
  $a=$this->makeCase();$b=$this->makeCase(['bono'=>$a->data['bono']]);$b->update(['status'=>'aprobada']);config(['demo.automatic_review'=>true]);$rules=app(AutoReviewService::class);$e=$rules->evaluate($b);
  $d=$b->data;$d['manual_review_signature']=hash('sha256',json_encode([$e['parameters'],$e['reasons'],$e['checks']]));$b->update(['data'=>$d]);$this->assertTrue($rules->evaluate($b)['requires_review']);
  try{app(DemoLicenciaService::class)->act($b,'pagar','pagador',[],$b->version);$this->fail('No debe omitir bloqueo');}catch(ValidationException $exception){$this->assertStringContainsString('bloqueo técnico',$exception->getMessage());}
  $token=\App\Http\Controllers\DemoAppController::credential($a);$this->withHeader('Authorization','Bearer '.$token)->postJson('/api/demo-app/expedientes/'.$a->id.'/acciones',['action'=>'explicar_revision','note'=>'Debí asistir a una consulta presencial.','version'=>$a->version])->assertOk();$this->assertSame('paciente',$a->fresh()->data['risk_explanations'][0]['role']);
 }}
