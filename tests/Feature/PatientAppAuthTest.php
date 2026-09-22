<?php

namespace Tests\Feature;

use App\Models\User;
use App\Services\DemoLicenciaService;
use App\Support\Rut;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class PatientAppAuthTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        config(['demo.risk_checks'=>false, 'demo.automatic_review'=>false, 'database.default'=>'sqlite', 'database.connections.sqlite.database'=>':memory:']);
        DB::purge('sqlite');
        require_once database_path('migrations/2014_10_12_000000_create_users_table.php');
        require_once database_path('migrations/2019_12_14_000001_create_personal_access_tokens_table.php');
        (new \CreateUsersTable())->up();
        (new \CreatePersonalAccessTokensTable())->up();
        (require database_path('migrations/2026_09_22_000000_add_app_identity_to_users.php'))->up();
        (require database_path('migrations/2026_09_22_000010_add_expires_at_to_personal_access_tokens.php'))->up();
        foreach (['2026_09_06_180000_create_demo_licencia_cases.php','2026_09_13_000000_create_demo_intake_tables.php','2026_09_13_010000_create_demo_filter_audits.php','2026_09_13_020000_add_professional_enabled.php','2026_09_13_030000_create_demo_care_relations.php','2026_09_13_040000_create_demo_workflow_audits.php','2026_09_13_050000_create_demo_review_settings.php'] as $migration) {
            (require database_path('migrations/'.$migration))->up();
        }
    }

    public function test_patient_can_login_and_only_list_cases_for_their_rut(): void
    {
        $own = app(DemoLicenciaService::class)->sample('empleador');
        $other = app(DemoLicenciaService::class)->sample('nuevo');
        $data = $other->data; $data['rut'] = '99.999.999-9'; $other->update(['data'=>$data]);
        User::create(['name'=>'Paciente Demo','email'=>'paciente@example.test','rut'=>$own->data['rut'],'password'=>Hash::make('demo-segura-2026'),'rol'=>'paciente','activo'=>true]);

        $login = $this->postJson('/api/patient-app/auth/login', ['login'=>'paciente@example.test','password'=>'demo-segura-2026','device_name'=>'phpunit'])
            ->assertOk()->assertJsonPath('user.rut', Rut::format($own->data['rut']));
        $token = $login->json('token');

        $this->withToken($token)->getJson('/api/patient-app/licencias')->assertOk()->assertJsonCount(1, 'data')->assertJsonPath('data.0.id', $own->id);
        $this->withToken($token)->getJson('/api/patient-app/licencias/'.$other->id)->assertForbidden();
    }

    public function test_patient_actions_require_a_valid_user_token(): void
    {
        $case = app(DemoLicenciaService::class)->sample('empleador');
        $user = User::create(['name'=>'Paciente Demo','email'=>'paciente2@example.test','rut'=>$case->data['rut'],'password'=>Hash::make('demo-segura-2026'),'rol'=>'paciente','activo'=>true]);
        $token = $user->createToken('phpunit', ['patient-app'])->plainTextToken;

        $this->postJson('/api/patient-app/licencias/'.$case->id.'/acciones', ['action'=>'ficha','version'=>$case->version])->assertUnauthorized();
        $this->withToken($token)->postJson('/api/patient-app/licencias/'.$case->id.'/acciones', ['action'=>'ficha','version'=>$case->version])->assertOk()->assertJsonPath('data.chronic_consent', true);
        $this->withToken($token)->postJson('/api/patient-app/auth/logout')->assertOk();
        $this->assertDatabaseCount('personal_access_tokens', 0);
    }

    public function test_inactive_accounts_cannot_login(): void
    {
        User::create(['name'=>'Usuario inactivo','email'=>'inactivo@example.test','rut'=>'11.111.111-1','password'=>Hash::make('demo-segura-2026'),'rol'=>'paciente','activo'=>false]);
        $this->postJson('/api/patient-app/auth/login', ['login'=>'inactivo@example.test','password'=>'demo-segura-2026'])
            ->assertUnprocessable()->assertJsonValidationErrors('login');
    }
}
