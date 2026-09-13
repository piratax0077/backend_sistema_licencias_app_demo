<?php

use App\Http\Controllers\LicenciaWebController;
use App\Services\LicenciaWorkflowService;
use App\Models\LicenciaPacienteAutorizacion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/', fn () => redirect('/licencia'));

Route::get('/licencia', [LicenciaWebController::class, 'index'])->name('licencia.index');
Route::post('/licencia', [LicenciaWebController::class, 'store'])->name('licencia.store');
Route::get('/empleador/licencias', [LicenciaWebController::class, 'empleador'])->name('empleador.licencias');

Route::get('/autorizar/{token}', function (string $token) {
    $autorizacion = LicenciaPacienteAutorizacion::with(['expediente.paciente', 'expediente.profesional'])->where('token', $token)->firstOrFail();

    return view('autorizar_licencia', compact('autorizacion'));
})->name('licencia.autorizar');

Route::post('/autorizar/{token}', function (Request $request, string $token, LicenciaWorkflowService $workflow) {
    $data = $request->validate([
        'aprueba' => 'required|boolean',
        'observacion' => 'nullable|string|max:1000',
    ]);

    $autorizacion = LicenciaPacienteAutorizacion::where('token', $token)->firstOrFail();
    $workflow->autorizarPaciente($autorizacion, (bool) $data['aprueba'], $data['observacion'] ?? null);

    return redirect('/licencia')->with('ok', 'Respuesta del paciente registrada.');
})->name('licencia.autorizar.responder');
