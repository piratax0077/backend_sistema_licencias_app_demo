<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\LicenciaPacienteAutorizacion;
use App\Models\LicenciaReposoDispositivo;
use App\Services\LicenciaWorkflowService;
use App\Support\Rut;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class LicenciasReposoAppController extends Controller
{
    public function __construct(private readonly LicenciaWorkflowService $workflow)
    {
    }

    public function registrarDispositivo(Request $request): JsonResponse
    {
        $data = $request->validate([
            'paciente_rut' => 'required|string|max:20',
            'device_token' => 'required|string|max:255',
            'plataforma' => 'nullable|string|max:40',
            'app_version' => 'nullable|string|max:40',
        ]);

        $pacienteRut = Rut::format($data['paciente_rut']);

        $device = LicenciaReposoDispositivo::updateOrCreate([
            'device_token' => $data['device_token'],
        ], [
            'paciente_rut' => $pacienteRut,
            'plataforma' => $data['plataforma'] ?? null,
            'app_version' => $data['app_version'] ?? null,
            'ultimo_contacto_at' => now(),
        ]);

        return response()->json([
            'ok' => true,
            'data' => $device,
        ]);
    }

    public function pendientes(Request $request): JsonResponse
    {
        $data = $request->validate([
            'paciente_rut' => 'required|string|max:20',
        ]);

        $pacienteRutClean = Rut::clean($data['paciente_rut']);

        $autorizaciones = LicenciaPacienteAutorizacion::with(['expediente.paciente', 'expediente.profesional'])
            ->where('estado', 'pendiente')
            ->whereHas('expediente.paciente', function ($query) use ($data) {
                $query->whereRaw("UPPER(REPLACE(REPLACE(REPLACE(rut, '.', ''), '-', ''), ' ', '')) = ?", [$pacienteRutClean]);
            })
            ->orderByDesc('id')
            ->get()
            ->map(function (LicenciaPacienteAutorizacion $autorizacion) {
                return [
                    'token' => $autorizacion->token,
                    'estado' => $autorizacion->estado,
                    'solicitada_at' => optional($autorizacion->solicitada_at)->toISOString(),
                    'payload' => $autorizacion->payload_app,
                ];
            });

        return response()->json([
            'ok' => true,
            'data' => $autorizaciones,
        ]);
    }

    public function responder(Request $request, string $token): JsonResponse
    {
        $data = $request->validate([
            'aprueba' => 'required|boolean',
            'observacion' => 'nullable|string|max:1000',
        ]);

        $autorizacion = LicenciaPacienteAutorizacion::where('token', $token)->firstOrFail();
        $expediente = $this->workflow->autorizarPaciente($autorizacion, (bool) $data['aprueba'], $data['observacion'] ?? null);

        return response()->json([
            'ok' => true,
            'data' => [
                'folio' => $expediente->folio,
                'estado' => $expediente->estado,
                'autorizacion' => $expediente->autorizacionPaciente,
            ],
        ]);
    }
}
