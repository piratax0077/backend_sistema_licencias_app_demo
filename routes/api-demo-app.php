<?php
use App\Http\Controllers\DemoAppController;
use Illuminate\Support\Facades\Route;
Route::get('/demo-app/expedientes/{case}', [DemoAppController::class,'show']);
Route::post('/demo-app/expedientes/{case}/acciones', [DemoAppController::class,'action']);
