<?php

namespace App\Http\Controllers\Api\Totem;

use App\Http\Controllers\Controller;
use App\Models\Totem;
use App\Models\TotemSesion;
use App\Models\TotemLog;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class AuthTotemController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'codigo' => 'required|string',
        ]);

        $totem = Totem::where('codigo', $request->codigo)->first();

        if (!$totem) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'Tótem no registrado'
            ], 404);
        }

        if (!$totem->activo) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'Tótem inactivo'
            ], 403);
        }

        if ($totem->ip_autorizada && $totem->ip_autorizada !== $request->ip()) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'IP no autorizada'
            ], 403);
        }

        $token = Str::random(80);

        $totem->update([
            'token' => $token,
            'ultimo_acceso' => now(),
        ]);

        TotemSesion::create([
            'totem_id' => $totem->id,
            'token' => $token,
            'inicio' => now(),
        ]);

        TotemLog::create([
            'totem_id' => $totem->id,
            'evento' => 'login',
            'detalle' => 'Login exitoso del tótem',
            'ip' => $request->ip(),
        ]);

        return response()->json([
            'ok' => true,
            'token' => $token,
            'totem' => [
                'id' => $totem->id,
                'codigo' => $totem->codigo,
                'nombre' => $totem->nombre,
                'ubicacion' => $totem->ubicacion,
                'version' => $totem->version,
            ]
        ]);
    }
}
