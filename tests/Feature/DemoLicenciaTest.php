<?php
namespace Tests\Feature;

use App\Models\DemoLicenciaCase;
use App\Services\DemoLicenciaService;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Tests\TestCase;

class DemoLicenciaTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        config(['demo.risk_checks'=>false,'demo.automatic_review'=>false,'database.default'=>'sqlite','database.connections.sqlite.database'=>':memory:']);
        DB::purge('sqlite');
        (require database_path('migrations/2026_09_06_180000_create_demo_licencia_cases.php'))->up();
        (require database_path('migrations/2026_09_13_000000_create_demo_intake_tables.php'))->up();
        (require database_path('migrations/2026_09_13_010000_create_demo_filter_audits.php'))->up();
        (require database_path('migrations/2026_09_13_020000_add_professional_enabled.php'))->up();
        (require database_path('migrations/2026_09_13_030000_create_demo_care_relations.php'))->up();
        (require database_path('migrations/2026_09_13_040000_create_demo_workflow_audits.php'))->up();
        (require database_path('migrations/2026_09_13_050000_create_demo_review_settings.php'))->up();
        (require database_path('migrations/2026_09_21_210000_add_medsdi_source_to_demo_catalog.php'))->up();
    }
    private function action($case, $action, $role, $input = []) {
        return app(DemoLicenciaService::class)->act($case,$action,$role,$input,$case->version);
    }
    public function test_full_circuit_issues_authorizes_submits_approves_and_pays_once(): void
    {
        $flow = app(DemoLicenciaService::class);
        $case = $flow->sample('nuevo');
        foreach (['bono','profesional','identidad','emitir'] as $step) { $case=$this->action($case,$step,'profesional'); }
        $this->assertSame('paciente',$case->status);
        $case=$this->action($case,'autorizar','paciente');
        foreach (array_keys($flow::DOCS) as $doc) { $case=$this->action($case,'documento','empleador',['document'=>$doc]); }
        $case=$this->action($case,'enviar','empleador',['monthly_net'=>900000]);
        $case=$this->action($case,'dictamen','contraloria',['decision'=>'aprobada','note'=>'Antecedentes ficticios suficientes.']);
        $case=$this->action($case,'pagar','pagador');
        $this->assertSame('pagada',$case->status);
        $this->assertSame(420000,$case->data['payment']['amount']);
        $this->assertCount(12,$case->data['events']);
        $this->expectException(ValidationException::class);
        $this->action($case,'pagar','pagador');
    }
    public function test_rejection_can_be_appealed_and_approved(): void
    {
        $case=app(DemoLicenciaService::class)->sample('rechazo');
        $case=$this->action($case,'apelar','paciente',['note'=>'Adjunto informe clínico ficticio ampliado.']);
        $this->assertSame('Reclamo ante COMPIN',$case->data['appeal_entity']);
        $case=$this->action($case,'resolver','contraloria',['decision'=>'mantener','note'=>'Los antecedentes ficticios no cambian el criterio.']);
        $case=$this->action($case,'apelar','paciente',['note'=>'Solicito reposición con antecedentes de ejemplo.']);
        $this->assertSame('Reposición ante COMPIN',$case->data['appeal_entity']);
        $case=$this->action($case,'resolver','contraloria',['decision'=>'acoger','note'=>'Se acoge la reposición del ejemplo.']);
        $this->assertSame('aprobada',$case->status);
        $this->assertSame(14,$case->data['approved_days']);
    }
    public function test_reduction_changes_payment_base_and_proposal_is_separate(): void
    {
        $flow=app(DemoLicenciaService::class); $case=$flow->sample('revision');
        $case=$this->action($case,'dictamen','contraloria',['decision'=>'reducida','approved_days'=>7,'note'=>'Se reducen los días en este ejemplo.']);
        $this->assertSame(120000,$flow->subsidy($case->data)['amount']);
        $this->assertSame(210000,$flow->subsidy($case->data,true)['amount']);
        $case=$this->action($case,'pagar','pagador');
        $this->assertSame(120000,$case->data['payment']['amount']);
    }
    public function test_emission_requires_all_verifications(): void
    {
        $case=app(DemoLicenciaService::class)->sample('nuevo');
        $this->expectException(ValidationException::class);
        $this->action($case,'emitir','profesional');
    }
    public function test_employer_cannot_send_incomplete_documents(): void
    {
        $case=app(DemoLicenciaService::class)->sample('empleador');
        $this->expectException(ValidationException::class);
        $this->action($case,'enviar','empleador',['monthly_net'=>900000]);
    }
    public function test_wrong_role_is_rejected(): void
    {
        $case=app(DemoLicenciaService::class)->sample('revision');
        $this->expectException(ValidationException::class);
        $this->action($case,'dictamen','empleador',['decision'=>'aprobada','note'=>'Intento desde perfil incorrecto.']);
    }
    public function test_stale_window_cannot_overwrite_new_state(): void
    {
        $case=app(DemoLicenciaService::class)->sample('nuevo');
        $this->action($case,'bono','profesional');
        $this->expectException(ValidationException::class);
        $this->action($case,'profesional','profesional');
    }
    public function test_audit_hold_blocks_resolution_until_human_release(): void
    {
        $case=app(DemoLicenciaService::class)->sample('revision');
        $case=$this->action($case,'alerta','auditor',['note'=>'Patrón ficticio requiere revisión.']);
        try { $this->action($case,'dictamen','contraloria',['decision'=>'aprobada','note'=>'Resolución ficticia suficiente.']); $this->fail('Debe impedir dictamen bajo revisión'); }
        catch (ValidationException $e) { $this->assertStringContainsString('alerta',$e->getMessage()); }
        $case=$this->action($case,'liberar','auditor',['note'=>'Revisión humana: antecedente ficticio aclarado.']);
        $case=$this->action($case,'dictamen','contraloria',['decision'=>'aprobada','note'=>'Resolución ficticia suficiente.']);
        $this->assertSame('aprobada',$case->status);
    }
    public function test_control_requires_explicit_consent(): void
    {
        $case=app(DemoLicenciaService::class)->sample('empleador');
        $this->expectException(ValidationException::class);
        $this->action($case,'control','paciente',['kind'=>'ubicacion']);
    }
    public function test_all_profile_pages_render_and_employer_does_not_see_diagnosis(): void
    {
        $case=app(DemoLicenciaService::class)->sample('revision');
        $this->get('/demo')->assertOk()->assertSee('Del paciente a la decisión clínica');
        foreach (array_keys(DemoLicenciaService::ROLES) as $role) {
            $response=$this->withSession(['demo_role'=>$role])->get('/demo/expedientes/'.$case->id)->assertOk();
            if ($role==='empleador') { $response->assertDontSee($case->data['diagnosis']); }
        }
        $this->get('/verificar/'.$case->data['token'])->assertOk()->assertDontSee($case->data['patient'])->assertDontSee($case->data['diagnosis']);
        $this->get('/demo/expedientes/'.$case->id.'/documentos/remuneraciones')->assertOk();
        $this->get('/demo/expedientes/'.$case->id.'/comprobante')->assertNotFound();
    }
    public function test_post_flow_persists_and_rejects_wrong_role(): void
    {
        $case=app(DemoLicenciaService::class)->sample('nuevo');
        $this->withSession(['demo_role'=>'profesional'])->post('/demo/expedientes/'.$case->id.'/accion',['action'=>'bono','version'=>1])->assertRedirect();
        $this->assertTrue($case->fresh()->data['verified_bono']);
        $this->withSession(['demo_role'=>'paciente'])->post('/demo/expedientes/'.$case->id.'/accion',['action'=>'profesional','version'=>2])->assertSessionHasErrors('workflow');
    }
    public function test_app_requires_a_dedicated_case_credential(): void
    {
        $case=app(DemoLicenciaService::class)->sample('empleador');
        $this->getJson('/api/demo-app/expedientes/'.$case->id)->assertForbidden();
        $this->withToken($case->data['token'])->getJson('/api/demo-app/expedientes/'.$case->id)->assertForbidden();
        $token=\App\Http\Controllers\DemoAppController::credential($case);
        $this->withToken($token)->getJson('/api/demo-app/expedientes/'.$case->id)->assertOk()->assertJsonPath('data.folio',$case->folio);
        $other=app(DemoLicenciaService::class)->sample('nuevo');
        $this->withToken($token)->getJson('/api/demo-app/expedientes/'.$other->id)->assertForbidden();
    }
    public function test_app_authorization_is_visible_in_portal_and_cannot_replay(): void
    {
        $case=app(DemoLicenciaService::class)->sample('nuevo');
        foreach(['bono','profesional','identidad','emitir'] as $step) { $case=$this->action($case,$step,'profesional'); }
        $token=\App\Http\Controllers\DemoAppController::credential($case);
        $this->withToken($token)->postJson('/api/demo-app/expedientes/'.$case->id.'/acciones',['action'=>'autorizar','version'=>$case->version])->assertOk()->assertJsonPath('data.status','empleador');
        $this->assertTrue($case->fresh()->data['consent']);
        $this->assertSame('App de control',array_slice($case->fresh()->data['events'],-1)[0]['source']);
        $this->get('/demo/expedientes/'.$case->id)->assertOk()->assertSee('Documentación laboral');
        $this->withToken($token)->postJson('/api/demo-app/expedientes/'.$case->id.'/acciones',['action'=>'autorizar','version'=>$case->version])->assertUnprocessable();
    }
    public function test_app_controls_and_consent_persist_on_same_case(): void
    {
        $case=app(DemoLicenciaService::class)->sample('empleador');
        $token=\App\Http\Controllers\DemoAppController::credential($case);
        $this->withToken($token)->postJson('/api/demo-app/expedientes/'.$case->id.'/acciones',['action'=>'control','kind'=>'ubicacion','version'=>$case->version])->assertUnprocessable();
        $this->withToken($token)->postJson('/api/demo-app/expedientes/'.$case->id.'/acciones',['action'=>'control','kind'=>'ubicacion','consent_control'=>'1','version'=>$case->version])->assertOk();
        $this->assertCount(1,$case->fresh()->data['controls']);
        $this->withToken($token)->postJson('/api/demo-app/expedientes/'.$case->id.'/acciones',['action'=>'pagar','version'=>$case->fresh()->version])->assertUnprocessable();
        $this->withToken($token)->postJson('/api/demo-app/expedientes/'.$case->id.'/acciones',['action'=>'ficha','version'=>$case->fresh()->version])->assertOk()->assertJsonPath('data.chronic_consent',true);
    }
    public function test_app_assets_are_served_from_same_source_and_paths_are_restricted(): void
    {
        $this->get('/app')->assertOk()->assertSee('App de control de licencias');
        $this->get('/app/js/integracion.js')->assertOk();
        $this->get('/app/css/integracion.css')->assertOk();
        $this->get('/app/config.xml')->assertNotFound();
        $this->get('/app/.env')->assertNotFound();
    }
    public function test_real_location_requires_consent_and_valid_coordinates(): void
    {
        $case=app(DemoLicenciaService::class)->sample('empleador');
        $token=\App\Http\Controllers\DemoAppController::credential($case);
        $body=['action'=>'control','kind'=>'ubicacion','capture_type'=>'geolocation','version'=>$case->version,'latitude'=>-33.45,'longitude'=>-70.66,'accuracy'=>25];
        $this->withToken($token)->postJson('/api/demo-app/expedientes/'.$case->id.'/acciones',$body)->assertUnprocessable();
        $this->withToken($token)->postJson('/api/demo-app/expedientes/'.$case->id.'/acciones',array_merge($body,['consent_control'=>'1','latitude'=>999]))->assertUnprocessable();
        $this->withToken($token)->postJson('/api/demo-app/expedientes/'.$case->id.'/acciones',$body+['consent_control'=>'1'])->assertOk();
        $control=$case->fresh()->data['controls'][0];
        $this->assertSame('geolocation',$control['capture_type']);
        $this->assertTrue($control['consent']);
        $this->assertSame(-33.45,$control['latitude']);
    }
    public function test_camera_permission_record_does_not_store_images(): void
    {
        $case=app(DemoLicenciaService::class)->sample('empleador');
        $token=\App\Http\Controllers\DemoAppController::credential($case);
        $this->withToken($token)->postJson('/api/demo-app/expedientes/'.$case->id.'/acciones',['action'=>'control','kind'=>'camara','capture_type'=>'camera','consent_control'=>'1','version'=>$case->version])->assertOk();
        $control=$case->fresh()->data['controls'][0];
        $this->assertSame('camera',$control['capture_type']);
        $this->assertArrayNotHasKey('image',$control);
        $this->assertStringContainsString('sin foto ni video',$control['result']);
    }
}
