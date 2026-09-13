<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\LicenciaEmpleador;
use App\Models\LicenciaPaciente;
use App\Models\User;
use App\Support\Rut;
use Illuminate\Http\JsonResponse;

class RutLookupController extends Controller
{
    public function show(string $rut): JsonResponse
    {
        $clean = Rut::clean($rut);

        abort_if($clean === null, 422, 'RUT invalido.');

        $whereNormalized = "UPPER(REPLACE(REPLACE(REPLACE(rut, '.', ''), '-', ''), ' ', '')) = ?";

        $paciente = LicenciaPaciente::query()
            ->whereRaw($whereNormalized, [$clean])
            ->orderByDesc('id')
            ->first();

        $empleador = LicenciaEmpleador::query()
            ->whereRaw($whereNormalized, [$clean])
            ->orderByDesc('id')
            ->first();

        $user = User::query()
            ->whereRaw($whereNormalized, [$clean])
            ->first();

        return response()->json([
            'ok' => true,
            'data' => [
                'rut' => Rut::format($clean),
                'rut_limpio' => $clean,
                'paciente' => $paciente ? [
                    'nombre' => $paciente->nombre,
                    'email' => $paciente->email,
                    'telefono' => $paciente->telefono,
                    'direccion' => $paciente->direccion,
                    'prevision' => $paciente->prevision,
                ] : null,
                'empleador' => $empleador ? [
                    'razon_social' => $empleador->razon_social,
                    'email' => $empleador->email,
                    'telefono' => $empleador->telefono,
                    'direccion' => $empleador->direccion,
                ] : null,
                'usuario' => $user ? [
                    'nombre' => $user->name,
                    'email' => $user->email,
                    'telefono' => $user->telefono,
                ] : null,
            ],
        ]);
    }
}
