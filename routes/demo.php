<?php
use App\Http\Controllers\DemoLicenciaController;
use Illuminate\Support\Facades\Route;
Route::get('/app/{asset?}', [\App\Http\Controllers\DemoAppController::class,'asset'])->where('asset','.*')->name('demo.app');
Route::get('/', [\App\Http\Controllers\DemoIntakeController::class,'index'])->name('demo.index');
Route::get('/demo', [\App\Http\Controllers\DemoIntakeController::class,'index']);
Route::post('/demo/perfil', [DemoLicenciaController::class,'role'])->name('demo.role');
Route::post('/demo/crear', fn() => redirect('/')->withErrors(['atencion'=>'Registra primero la atención de origen.']))->name('demo.create');
Route::post('/demo/escenario', fn() => redirect('/')->withErrors(['atencion'=>'La base inicia limpia. Registra los datos desde la atención.']))->name('demo.sample');
Route::get('/demo/expedientes/{case}', [DemoLicenciaController::class,'show'])->name('demo.show');
Route::post('/demo/expedientes/{case}/accion', [DemoLicenciaController::class,'action'])->name('demo.action');
Route::get('/demo/expedientes/{case}/documentos/{document}', [DemoLicenciaController::class,'document'])->name('demo.document');
Route::get('/demo/expedientes/{case}/comprobante', [DemoLicenciaController::class,'receipt'])->name('demo.receipt');
Route::get('/verificar/{token}', [DemoLicenciaController::class,'verify'])->name('demo.verify');
Route::post('/demo/atenciones', [\App\Http\Controllers\DemoIntakeController::class,'save']);
Route::post('/demo/relaciones', [\App\Http\Controllers\DemoIntakeController::class,'saveRelation']);
Route::delete('/demo/atenciones/{id}', [\App\Http\Controllers\DemoIntakeController::class,'remove']);
Route::post('/demo/auditoria/{id}/revisar', [\App\Http\Controllers\DemoIntakeController::class,'review']);

Route::get('/demo/atenciones/{id}/informe', [\App\Http\Controllers\DemoIntakeController::class,'report']);
Route::get('/demo/circuito', [\App\Http\Controllers\DemoCircuitController::class,'index']);
Route::post('/demo/circuito/preparar', [\App\Http\Controllers\DemoCircuitController::class,'prepare']);
Route::post('/demo/circuito/{case}/accion', [\App\Http\Controllers\DemoCircuitController::class,'action']);
Route::post('/demo/contraloria/parametros', [\App\Http\Controllers\ReviewSettingsController::class,'save']);
Route::post('/demo/contraloria/{case}/referencia', [\App\Http\Controllers\ReviewSettingsController::class,'reference']);
Route::post('/demo/riesgos/operador', [\App\Http\Controllers\RiskEvidenceController::class,'operator']);
Route::post('/demo/riesgos/{case}/evidencia', [\App\Http\Controllers\RiskEvidenceController::class,'save']);
Route::post('/demo/riesgos/{case}/revalidar', [\App\Http\Controllers\RiskEvidenceController::class,'attest']);
Route::post('/demo/riesgos/{case}/explicacion', [\App\Http\Controllers\RiskEvidenceController::class,'explain']);
