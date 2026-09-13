<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ClienteAutorizacion;
use App\Models\ClienteDispositivo;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Helpers\SecurityLogger;

class ClienteAutorizacionController extends Controller
{
    public function registrarDispositivo(Request $request)
    {
        $request->validate([
            'cliente_id' => 'required|integer',
            'imei' => 'required|string',
            'device_token' => 'nullable|string',
            'nombre_dispositivo' => 'nullable|string',
        ]);

        $imeiHash = hash('sha256', $request->imei);

        $dispositivo = ClienteDispositivo::updateOrCreate(
            ['imei_hash' => $imeiHash],
            [
                'cliente_id' => $request->cliente_id,
                'device_token' => $request->device_token,
                'nombre_dispositivo' => $request->nombre_dispositivo,
                'estado' => 'activo',
                'ultimo_uso_at' => now(),
                'ip_registro' => $request->ip(),
            ]
        );

        return response()->json([
            'ok' => true,
            'dispositivo' => $dispositivo,
            'mensaje' => 'Dispositivo registrado correctamente',
        ]);

        SecurityLogger::log(
            'dispositivo_cliente_registrado',
            'ClienteDispositivo',
            $dispositivo->id,
            'ok',
            'Dispositivo registrado o actualizado por app autorizadora',
            $dispositivo->cliente_id
        );
    }

    public function solicitar(Request $request)
    {
        $request->validate([
            'cliente_id' => 'required|integer',
            'tipo_accion' => 'required|string',
            'referencia_tipo' => 'nullable|string',
            'referencia_id' => 'nullable|integer',
        ]);

       $dispositivo = ClienteDispositivo::where('cliente_id', $request->cliente_id)
        ->where('estado', 'activo')
        ->orderBy('id', 'asc')
        ->first();

        if (!$dispositivo) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'Cliente no tiene dispositivo autorizado',
            ], 403);
        }

        $autorizacion = ClienteAutorizacion::create([
            'cliente_id' => $request->cliente_id,
            'dispositivo_id' => $dispositivo->id,
            'tipo_accion' => $request->tipo_accion,
            'referencia_tipo' => $request->referencia_tipo,
            'referencia_id' => $request->referencia_id,
            'token' => Str::random(80),
            'estado' => 'pendiente',
            'ip_solicitante' => $request->ip(),
            'expira_at' => now()->addMinutes(5),

        ]);

        return response()->json([
            'ok' => true,
            'autorizacion_id' => $autorizacion->id,
            'token' => $autorizacion->token,
            'estado' => $autorizacion->estado,
            'expira_at' => $autorizacion->expira_at,
            'mensaje' => 'Solicitud enviada a la app del cliente',
        ]);
        SecurityLogger::log(
            'autorizacion_sensible_solicitada',
            'ClienteAutorizacion',
            $autorizacion->id,
            'pendiente',
            'Solicitud de autorización: '.$autorizacion->tipo_accion,
            $autorizacion->cliente_id
        );
    }

    public function pendientes(Request $request)
    {
        $request->validate([
            'imei' => 'required|string',
        ]);

        $imeiHash = hash('sha256', $request->imei);

        $dispositivo = ClienteDispositivo::where('imei_hash', $imeiHash)
            ->where('estado', 'activo')
            ->first();

        if (!$dispositivo) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'Dispositivo no autorizado',
            ], 403);
        }

        $pendientes = ClienteAutorizacion::where('dispositivo_id', $dispositivo->id)
            ->where('estado', 'pendiente')
            ->where('expira_at', '>', now())
            ->latest()
            ->get();

        return response()->json([
            'ok' => true,
            'pendientes' => $pendientes,
        ]);
    }

    public function responder(Request $request)
    {
        $request->validate([
            'imei' => 'required|string',
            'token' => 'required|string',
            'respuesta' => 'required|string|in:aprobar,rechazar',
        ]);

        $imeiHash = hash('sha256', $request->imei);

        $dispositivo = ClienteDispositivo::where('imei_hash', $imeiHash)
            ->where('estado', 'activo')
            ->first();

        if (!$dispositivo) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'Dispositivo no autorizado',
            ], 403);
        }

        $autorizacion = ClienteAutorizacion::where('token', $request->token)
            ->where('dispositivo_id', $dispositivo->id)
            ->where('estado', 'pendiente')
            ->first();

        if (!$autorizacion) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'Autorización no encontrada o ya procesada',
            ], 404);
        }

        if ($autorizacion->expira_at && now()->gt($autorizacion->expira_at)) {
            $autorizacion->update([
                'estado' => 'expirada',
            ]);

            return response()->json([
                'ok' => false,
                'mensaje' => 'Autorización expirada',
            ], 400);
        }

        if ($request->respuesta === 'aprobar') {
            $autorizacion->update([
                'estado' => 'aprobada',
                'aprobada_at' => now(),
            ]);
        } else {
            $autorizacion->update([
                'estado' => 'rechazada',
                'rechazada_at' => now(),
            ]);
        }
        SecurityLogger::log(
            'autorizacion_sensible_'.$autorizacion->fresh()->estado,
            'ClienteAutorizacion',
            $autorizacion->id,
            $autorizacion->fresh()->estado,
            'Respuesta enviada desde dispositivo autorizado',
            $autorizacion->cliente_id
        );
        return response()->json([
            'ok' => true,
            'estado' => $autorizacion->fresh()->estado,
            'mensaje' => 'Respuesta registrada correctamente',
        ]);
    }

    public function verificar($token)
    {
        $autorizacion = ClienteAutorizacion::where('token', $token)->first();

        if (!$autorizacion) {
            return response()->json([
                'ok' => false,
                'estado' => 'no_encontrada',
            ], 404);
        }

        if ($autorizacion->estado === 'pendiente' &&
            $autorizacion->expira_at &&
            now()->gt($autorizacion->expira_at)) {

            $autorizacion->update([
                'estado' => 'expirada',
            ]);
        }

        return response()->json([
            'ok' => true,
            'estado' => $autorizacion->fresh()->estado,
            'autorizacion' => $autorizacion->fresh(),
        ]);
    }
}
