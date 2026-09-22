<?php
use App\Http\Controllers\DemoAppController;
use App\Http\Controllers\Api\PatientAppAuthController;
use Illuminate\Support\Facades\Route;

Route::post('/patient-app/auth/login', [PatientAppAuthController::class, 'login'])
    ->middleware('throttle:10,1');
Route::middleware(['auth:sanctum'])->prefix('patient-app')->group(function () {
    Route::get('/auth/me', [PatientAppAuthController::class, 'me']);
    Route::post('/auth/logout', [PatientAppAuthController::class, 'logout']);
    Route::get('/licencias', [DemoAppController::class, 'patientIndex']);
    Route::get('/licencias/{case}', [DemoAppController::class, 'patientShow']);
    Route::post('/licencias/{case}/acciones', [DemoAppController::class, 'patientAction']);
});

// Compatibilidad temporal con los enlaces firmados de la versión anterior.
Route::get('/demo-app/expedientes/{case}', [DemoAppController::class,'show']);
Route::post('/demo-app/expedientes/{case}/acciones', [DemoAppController::class,'action']);
