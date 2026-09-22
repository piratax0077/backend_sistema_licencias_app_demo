<?php

use App\Http\Controllers\Api\LicenciaApiController;
use App\Http\Controllers\Api\LicenciasReposoAppController;
use App\Http\Controllers\Api\RutLookupController;
use App\Http\Controllers\Api\DemoCatalogController;
use Illuminate\Support\Facades\Route;

Route::get('/personas/rut/{rut}', [RutLookupController::class, 'show']);
Route::get('/demo/catalog/{type}/rut/{rut}', [DemoCatalogController::class, 'byRut']);

Route::prefix('licencias')->group(function () {
    Route::post('/emitir', [LicenciaApiController::class, 'emitir']);
    Route::get('/{folio}', [LicenciaApiController::class, 'show']);
    Route::post('/autorizaciones/{token}/responder', [LicenciaApiController::class, 'responderAutorizacion']);
    Route::get('/empleadores/{rut}/pendientes', [LicenciaApiController::class, 'empleadorPendientes']);
    Route::post('/empleadores/{empleador}/preparar-documentacion', [LicenciaApiController::class, 'prepararDocumentacion']);
    Route::post('/documentos/{documento}/adjuntar', [LicenciaApiController::class, 'adjuntarDocumento']);
});

Route::prefix('licencias-reposo')->group(function () {
    Route::post('/dispositivos', [LicenciasReposoAppController::class, 'registrarDispositivo']);
    Route::post('/pendientes', [LicenciasReposoAppController::class, 'pendientes']);
    Route::post('/autorizaciones/{token}/responder', [LicenciasReposoAppController::class, 'responder']);
});

require __DIR__.'/api-demo-app.php';
