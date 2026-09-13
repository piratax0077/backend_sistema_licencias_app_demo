<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use App\Models\Totem;

class AuthTotem
{
    public function handle(Request $request, Closure $next)
    {
        $token = $request->header('X-TOTEM-TOKEN');

        if (!$token) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'Token no enviado'
            ], 401);
        }

        $totem = Totem::where('token', $token)
            ->where('activo', true)
            ->first();

        if (!$totem) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'Token inválido'
            ], 401);
        }

        $totem->update([
            'ultimo_acceso' => now(),
            'ultimo_ping' => now(),
        ]);

        $request->merge([
            'totem' => $totem
        ]);

        return $next($request);
    }
}
