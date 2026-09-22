<?php
namespace Tests\Feature;
use Tests\TestCase;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;
use App\Models\DemoLicenciaCase;
use App\Services\DemoLicenciaService;
class DemoIntakeTest extends TestCase {
 protected function setUp():void {parent::setUp();config(['demo.risk_checks'=>false,'demo.automatic_review'=>false,'database.default'=>'sqlite','database.connections.sqlite.database'=>':memory:']);DB::purge('sqlite');foreach(['2026_09_06_180000_create_demo_licencia_cases.php','2026_09_13_000000_create_demo_intake_tables.php','2026_09_13_010000_create_demo_filter_audits.php','2026_09_13_020000_add_professional_enabled.php','2026_09_13_030000_create_demo_care_relations.php','2026_09_13_040000_create_demo_workflow_audits.php','2026_09_13_050000_create_demo_review_settings.php','2026_09_21_210000_add_medsdi_source_to_demo_catalog.php'] as $m)(require database_path('migrations/'.$m))->up();}
 private function input():array {
  foreach(['patients'=>['Ana','1-9'],'professionals'=>['Dr. Sol','Medicina'],'sites'=>['Centro','presencial']] as $type=>$data)DB::table('demo_'.$type)->insert(['name'=>$data[0],'detail'=>$data[1],'created_at'=>now(),'updated_at'=>now()]);
  return ['professional_enabled'=>1,'patient_id'=>1,'professional_id'=>1,'site_id'=>1,'appointment_at'=>'2026-09-13T10:00','appointment_mode'=>'presencial','started_at'=>'2026-09-13T10:05','ended_at'=>'2026-09-13T10:25','mode'=>'presencial','bono'=>'B123','bono_verified'=>1,'decision'=>'sin_licencia','diagnosis'=>'Consulta demo','insurance'=>'Fonasa','address'=>'Calle demo','days'=>5,'start'=>'2026-09-13'];
 }
 public function test_empty_database_and_no_leave_consultation_can_be_edited_and_deleted():void {
  $this->get('/')->assertOk()->assertSee('Sin atenciones');$v=$this->input();$this->post('/demo/atenciones',$v)->assertRedirect('/');$this->assertSame(0,DemoLicenciaCase::count());$this->get('/demo/atenciones/1/informe')->assertOk()->assertSee('Informe de atención #1')->assertSee('20 minutos');$this->get('/demo/atenciones/1/informe?imprimir=1')->assertOk()->assertSee('window.print()',false);
  $this->post('/demo/datos/patients',['name'=>'Otro','detail'=>'2-7'])->assertNotFound();$this->delete('/demo/datos/patients/1')->assertNotFound();
  $v['id']=1;$v['diagnosis']='Control actualizado';$this->post('/demo/atenciones',$v)->assertRedirect('/');$this->assertDatabaseHas('demo_consultations',['diagnosis'=>'Control actualizado']);
  $this->delete('/demo/atenciones/1')->assertRedirect('/');$this->assertDatabaseCount('demo_patients',1);
 }
 public function test_first_filter_links_participants_and_existing_app_flow():void {
  $v=$this->input();$v['decision']='con_licencia';$this->post('/demo/atenciones',$v)->assertRedirect();$c=DemoLicenciaCase::firstOrFail();$this->assertTrue($c->data['first_filter_passed']);$this->assertSame(20,$c->data['first_filter']['3. Minutos de consulta']);$this->assertSame('Dr. Sol',$c->data['doctor']);$this->get('/demo/expedientes/'.$c->id)->assertOk()->assertSee('Primer filtro');
  $flow=app(DemoLicenciaService::class);foreach(['profesional','identidad','emitir'] as $a)$c=$flow->act($c,$a,'profesional',[],$c->version);$this->assertSame('paciente',$c->status);
  $v['id']=1;$this->post('/demo/atenciones',$v)->assertSessionHasErrors('id');$this->delete('/demo/atenciones/1')->assertRedirect('/');$this->assertDatabaseCount('demo_licencia_cases',0);
 }
 public function test_unconfirmed_professional_blocks_filter_and_creates_notice():void {
  $v=$this->input();$v['decision']='con_licencia';unset($v['professional_enabled']);$this->post('/demo/atenciones',$v)->assertRedirect();$c=DemoLicenciaCase::firstOrFail();$this->assertFalse($c->data['first_filter_passed']);$this->assertStringContainsString('habilitación',$c->data['filter_notification']);$this->assertDatabaseHas('demo_filter_audits',['case_id'=>$c->id,'passed'=>0]);$this->post('/demo/expedientes/'.$c->id.'/accion',['action'=>'emitir','version'=>$c->version])->assertSessionHasErrors();
 }
 public function test_mismatched_mode_blocks_issuance_and_no_direct_case_bypass():void {
  $v=$this->input();$v['decision']='con_licencia';$v['appointment_mode']='telematica';$this->post('/demo/atenciones',$v);$c=DemoLicenciaCase::firstOrFail();$this->assertFalse($c->data['first_filter_passed']);
  $this->post('/demo/expedientes/'.$c->id.'/accion',['action'=>'emitir','version'=>$c->version])->assertSessionHasErrors();$this->post('/demo/crear',[])->assertRedirect('/');$this->post('/demo/escenario',['scenario'=>'nuevo'])->assertRedirect('/');$this->assertSame(1,DemoLicenciaCase::count());
 }
 public function test_professional_only_accepts_its_medsdi_sites():void {
  $v=$this->input();
  DB::table('demo_sites')->insert(['id'=>2,'name'=>'Centro externo','detail'=>'presencial']);
  DB::table('demo_professional_sites')->insert(['professional_id'=>1,'site_id'=>1,'source'=>'medsdi']);
  $this->get('/')->assertOk()->assertSee('professionalSites');
  $v['site_id']=2;
  $this->post('/demo/atenciones',$v)->assertSessionHasErrors('site_id');
  $v['site_id']=1;
  $this->post('/demo/atenciones',$v)->assertRedirect('/');
 }
 public function test_relation_can_be_saved_without_registering_an_attention():void {
  $this->input();
  DB::table('demo_sites')->insert(['id'=>2,'name'=>'Centro ajeno','detail'=>'presencial']);
  DB::table('demo_professional_sites')->insert(['professional_id'=>1,'site_id'=>1,'source'=>'medsdi']);
  $this->post('/demo/relaciones',['patient_id'=>1,'professional_id'=>1,'site_id'=>2])->assertSessionHasErrors('site_id');
  $this->post('/demo/relaciones',['patient_id'=>1,'professional_id'=>1,'site_id'=>1])->assertRedirect('/')->assertSessionHas('ok');
  $this->assertDatabaseHas('demo_care_relations',['patient_id'=>1,'professional_id'=>1,'site_id'=>1]);
  $this->assertDatabaseCount('demo_consultations',0);
 }
 public function test_rut_search_uses_medsdi_backend_and_stores_local_references():void {
  config(['medsdi.api_url'=>'http://medsdi.test','medsdi.integration_key'=>'shared-test-key']);
  Http::fake([
   'http://medsdi.test/api/integraciones/licencias/catalogo/pacientes/rut/*'=>Http::response(['data'=>['external_id'=>501,'rut'=>'11.111.111-1','name'=>'Paciente Med-SDI','status'=>1]]),
   'http://medsdi.test/api/integraciones/licencias/catalogo/profesionales/rut/*'=>Http::response(['data'=>['external_id'=>601,'rut'=>'22.222.222-2','name'=>'Profesional Med-SDI','specialty'=>'Medicina general','status'=>1,'certified'=>1,'specialty_id'=>7,'sites'=>[['relation_id'=>801,'external_id'=>701,'name'=>'Centro Med-SDI','address'=>'Calle 1','city'=>'Valparaíso','type'=>1]]]]),
  ]);

  $this->getJson('/api/demo/catalog/patients/rut/11.111.111-1')->assertOk()->assertJsonPath('data.name','Paciente Med-SDI');
  $this->getJson('/api/demo/catalog/professionals/rut/22.222.222-2')->assertOk()->assertJsonPath('data.sites.0.name','Centro Med-SDI · Calle 1 · Valparaíso');
  $this->assertDatabaseHas('demo_patients',['source'=>'medsdi','external_id'=>501]);
  $this->assertDatabaseHas('demo_professionals',['source'=>'medsdi','external_id'=>601]);
  $this->assertDatabaseHas('demo_sites',['source'=>'medsdi','external_id'=>701]);
  $this->assertDatabaseCount('demo_professional_sites',1);
  Http::assertSent(fn($request)=>$request->hasHeader('X-Integration-Key','shared-test-key'));
 }
 public function test_failed_filter_notifies_app_and_audit_survives_correction_and_deletion():void {
  $v=$this->input();$v['decision']='con_licencia';$v['bono_verified']=0;$this->post('/demo/atenciones',$v);$c=DemoLicenciaCase::firstOrFail();
  $this->assertDatabaseHas('demo_filter_audits',['case_id'=>$c->id,'passed'=>0,'reviewed_at'=>null]);
  $token=\App\Http\Controllers\DemoAppController::credential($c);
  $this->withHeader('Authorization','Bearer '.$token)->getJson('/api/demo-app/expedientes/'.$c->id)->assertOk()->assertJsonPath('data.filter_notification',$c->data['filter_notification']);
  $this->withSession(['demo_role'=>'contraloria'])->get('/')->assertOk()->assertSee('No superado');
  $this->post('/demo/auditoria/1/revisar',['note'=>'Se solicita corregir bono.'])->assertRedirect('/#auditoria');
  $this->assertNotNull(DB::table('demo_filter_audits')->find(1)->reviewed_at);
  $this->withSession(['demo_role'=>'profesional']);$v['id']=1;$v['bono_verified']=1;$this->post('/demo/atenciones',$v)->assertRedirect();
  $this->assertSame($c->id,DemoLicenciaCase::first()->id);$this->assertDatabaseCount('demo_filter_audits',2);$this->assertTrue($c->fresh()->data['first_filter_passed']);$this->assertNull($c->fresh()->data['filter_notification']);
  $this->delete('/demo/atenciones/1')->assertRedirect('/');$this->assertDatabaseCount('demo_filter_audits',2);$this->assertNull(DB::table('demo_filter_audits')->find(1)->case_id);
 }
 public function test_patient_employer_payer_circuit_and_rejection_stop():void {
  $v=$this->input();$this->post('/demo/atenciones',$v);
  $this->withSession(['demo_role'=>'paciente'])->post('/demo/circuito/preparar',['patient_id'=>1])->assertRedirect('/demo/circuito');
  $c=DemoLicenciaCase::latest('id')->firstOrFail();$this->assertSame('paciente',$c->status);$this->get('/')->assertOk()->assertSee('Abrir app para aprobar');
  $token=\App\Http\Controllers\DemoAppController::credential($c);
  $this->withHeader('Authorization','Bearer '.$token)->postJson('/api/demo-app/expedientes/'.$c->id.'/acciones',['action'=>'autorizar','version'=>$c->version])->assertOk();$c=$c->fresh();$this->assertSame('empleador',$c->status);
  $this->withSession(['demo_role'=>'empleador'])->post('/demo/circuito/'.$c->id.'/accion',['action'=>'antecedentes','version'=>(string)$c->version])->assertRedirect('/demo/circuito')->assertSessionDoesntHaveErrors();$c=$c->fresh();$this->assertSame('revision',$c->status);$this->assertCount(3,$c->data['payrolls']);
  $this->withSession(['demo_role'=>'pagador'])->post('/demo/circuito/'.$c->id.'/accion',['action'=>'pagar','version'=>$c->version])->assertSessionHasErrors();
  $this->assertDatabaseHas('demo_workflow_audits',['folio'=>$c->folio,'action'=>'pagar','result'=>'bloqueado']);
  $this->withSession(['demo_role'=>'contraloria'])->post('/demo/circuito/'.$c->id.'/accion',['action'=>'dictamen','version'=>$c->version])->assertRedirect();$c=$c->fresh();
  $this->withSession(['demo_role'=>'pagador'])->post('/demo/circuito/'.$c->id.'/accion',['action'=>'pagar','version'=>$c->version])->assertRedirect();$this->assertSame('pagada',$c->fresh()->status);
  $this->withSession(['demo_role'=>'paciente'])->post('/demo/circuito/preparar',['patient_id'=>1])->assertRedirect();$rejected=DemoLicenciaCase::latest('id')->firstOrFail();
  $this->post('/demo/circuito/'.$rejected->id.'/accion',['action'=>'no_autorizar','version'=>$rejected->version])->assertRedirect();$rejected=$rejected->fresh();$this->assertSame('cancelada',$rejected->status);
  $this->withSession(['demo_role'=>'empleador'])->post('/demo/circuito/'.$rejected->id.'/accion',['action'=>'antecedentes','version'=>$rejected->version])->assertSessionHasErrors();$this->assertEmpty($rejected->fresh()->data['documents']);
 } public function test_app_responds_to_contraloria_permits_independently():void {
  $flow=app(DemoLicenciaService::class);$c=$flow->sample('empleador');
  $c=$flow->act($c,'solicitar_control','contraloria',['kind'=>'camara','note'=>'Verificación consentida del reposo.'],$c->version);
  $c=$flow->act($c,'solicitar_control','contraloria',['kind'=>'ubicacion','note'=>'Verificación puntual de ubicación.'],$c->version);
  $token=\App\Http\Controllers\DemoAppController::credential($c);$req=$c->data['control_requests'][0];
  $this->withHeader('Authorization','Bearer '.$token)->postJson('/api/demo-app/expedientes/'.$c->id.'/acciones',['action'=>'responder_control','control_request_id'=>$req['id'],'decision'=>'aprobar','version'=>$c->version])->assertOk()->assertJsonPath('data.control_requests.0.status','aprobada')->assertJsonPath('data.control_requests.1.status','pendiente');
  $c=$c->fresh();$this->assertEmpty($c->data['controls']);
  $this->postJson('/api/demo-app/expedientes/'.$c->id.'/acciones',['action'=>'responder_control','control_request_id'=>$req['id'],'decision'=>'rechazar','version'=>$c->version])->assertStatus(422);
  $this->postJson('/api/demo-app/expedientes/'.$c->id.'/acciones',['action'=>'responder_control','control_request_id'=>$c->data['control_requests'][1]['id'],'decision'=>'rechazar','version'=>$c->version])->assertOk()->assertJsonPath('data.control_requests.1.status','rechazada');
  $this->assertDatabaseHas('demo_workflow_audits',['folio'=>$c->folio,'action'=>'responder_control','channel'=>'app','result'=>'aceptado']);
 } public function test_automatic_review_radius_days_sequence_and_payment_guard():void {
  $flow=app(DemoLicenciaService::class);$case=$flow->sample('revision');config(['demo.automatic_review'=>true]);$rules=app(\App\Services\AutoReviewService::class);
  $p=$rules->settings();$p['check_origin']=false;$p['min_minutes']=0;$p['review_from']=2;$p['max_days']=30;
  DB::table('demo_review_settings')->where('id',1)->update(['data'=>json_encode($p)]);
  $this->assertTrue($rules->evaluate($case)['requires_review']);
  $d=$case->data;$d['rest_coordinates']=['latitude'=>-33.45,'longitude'=>-70.66];$d['controls'][]=['capture_type'=>'geolocation','latitude'=>-33.45,'longitude'=>-70.66,'accuracy'=>10];$case->update(['data'=>$d]);
  $this->assertFalse($rules->evaluate($case)['requires_review']);$case=$rules->refresh($case);$this->assertSame('aprobada',$case->status);
  $d=$case->data;$d['controls'][0]['latitude']=-33.48;$case->update(['data'=>$d]);$result=$rules->evaluate($case);$this->assertTrue($result['requires_review']);$this->assertGreaterThan(3,$result['distance_km']);
  $this->withSession(['demo_role'=>'pagador'])->post('/demo/circuito/'.$case->id.'/accion',['action'=>'pagar','version'=>$case->version])->assertSessionHasErrors();
  $p['radius_km']=5;DB::table('demo_review_settings')->where('id',1)->update(['data'=>json_encode($p)]);$this->assertFalse($rules->evaluate($case)['requires_review']);
  $p['max_days']=1;DB::table('demo_review_settings')->where('id',1)->update(['data'=>json_encode($p)]);$this->assertTrue($rules->evaluate($case)['requires_review']);
  $p['max_days']=30;$p['review_from']=1;DB::table('demo_review_settings')->where('id',1)->update(['data'=>json_encode($p)]);$this->assertTrue($rules->evaluate($case)['requires_review']);
  $this->withSession(['demo_role'=>'contraloria'])->get('/')->assertOk()->assertSee('Parámetros de revisión automática');
 }}
