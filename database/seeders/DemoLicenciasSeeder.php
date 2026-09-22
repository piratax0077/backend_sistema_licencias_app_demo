<?php
namespace Database\Seeders;
use Illuminate\Database\Seeder;
use App\Models\DemoLicenciaCase;
use App\Services\DemoLicenciaService;
class DemoLicenciasSeeder extends Seeder {
    public function run(): void {
        $flow = app(DemoLicenciaService::class);
        foreach (['nuevo','empleador','revision','rechazo'] as $scenario) {
            if (!DemoLicenciaCase::where('data->scenario',$scenario)->exists()) { $flow->sample($scenario); }
        }
    }
}
