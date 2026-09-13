<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\LicenciaDocumentoRequerido;
use App\Models\LicenciaEmpleador;
use App\Models\LicenciaExpediente;
use App\Models\LicenciaPacienteAutorizacion;
use App\Services\LicenciaWorkflowService;
use App\Support\Rut;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class LicenciaApiController extends Controller
{
    public function __construct(private readonly LicenciaWorkflowService $workflow)
    {
    }

    public function emitir(Request $request): JsonResponse
    {
        $data = $request->validate([
            'folio' => 'nullable|string|max:80',
            'tipo_licencia' => 'nullable|string|max:80',
            'dias_reposo' => 'nullable|integer|min:1|max:365',
            'fecha_emision' => 'nullable|date',
            'fecha_inicio_reposo' => 'nullable|date',
            'fecha_fin_reposo' => 'nullable|date',
            'diagnostico_codigo' => 'nullable|string|max:40',
            'diagnostico_descripcion' => 'nullable|string',
            'paciente.rut' => 'required|string|max:20',
            'paciente.nombre' => 'required|string|max:255',
            'paciente.email' => 'nullable|email|max:255',
            'paciente.telefono' => 'nullable|string|max:30',
            'paciente.direccion' => 'nullable|string|max:255',
            'paciente.prevision' => 'nullable|string|max:80',
            'profesional.rut' => 'nullable|string|max:20',
            'profesional.nombre' => 'required|string|max:255',
            'profesional.especialidad' => 'nullable|string|max:120',
            'profesional.email' => 'nullable|email|max:255',
            'profesional.firma_hash' => 'nullable|string|max:255',
            'empleadores' => 'required|array|min:1',
            'empleadores.*.rut' => 'nullable|string|max:20',
            'empleadores.*.razon_social' => 'required|string|max:255',
            'empleadores.*.email' => 'nullable|email|max:255',
            'empleadores.*.telefono' => 'nullable|string|max:30',
            'empleadores.*.direccion' => 'nullable|string|max:255',
            'empleadores.*.afiliado_ccaf' => 'nullable|boolean',
            'empleadores.*.ccaf_nombre' => 'nullable|string|max:120',
        ]);

        $data['paciente']['rut'] = Rut::format($data['paciente']['rut']);
        $data['profesional']['rut'] = Rut::format($data['profesional']['rut'] ?? null);

        foreach ($data['empleadores'] as $index => $empleador) {
            $data['empleadores'][$index]['rut'] = Rut::format($empleador['rut'] ?? null);
        }

        $expediente = DB::transaction(function () use ($data) {
            $expediente = LicenciaExpediente::create([
                'folio' => $data['folio'] ?? $this->generarFolio(),
                'estado' => LicenciaWorkflowService::ESTADO_PENDIENTE_AUTORIZACION,
                'origen' => 'licencia_blade_api',
                'tipo_licencia' => $data['tipo_licencia'] ?? null,
                'dias_reposo' => $data['dias_reposo'] ?? null,
                'fecha_emision' => $data['fecha_emision'] ?? now()->toDateString(),
                'fecha_inicio_reposo' => $data['fecha_inicio_reposo'] ?? null,
                'fecha_fin_reposo' => $data['fecha_fin_reposo'] ?? null,
                'diagnostico_codigo' => $data['diagnostico_codigo'] ?? null,
                'diagnostico_descripcion' => $data['diagnostico_descripcion'] ?? null,
            ]);

            $expediente->paciente()->create($data['paciente']);
            $expediente->profesional()->create(array_merge($data['profesional'], [
                'emitida_at' => now(),
            ]));

            foreach ($data['empleadores'] as $empleadorData) {
                $empleador = $expediente->empleadores()->create(array_merge($empleadorData, [
                    'afiliado_ccaf' => (bool) ($empleadorData['afiliado_ccaf'] ?? false),
                    'estado' => 'bloqueado_por_autorizacion',
                ]));
                $this->workflow->crearDocumentosBase($expediente, $empleador);
            }

            $this->workflow->crearAutorizacionPaciente($expediente);
            $this->workflow->evento($expediente, 'profesional', 'licencia_emitida', 'Licencia creada; envio a empleador bloqueado hasta autorizacion del paciente.');

            return $expediente;
        });

        return response()->json([
            'ok' => true,
            'message' => 'Licencia creada. Pendiente autorizacion del paciente antes de notificar empleador(es).',
            'data' => $this->loadExpediente($expediente->folio),
        ], 201);
    }

    public function show(string $folio): JsonResponse
    {
        return response()->json([
            'ok' => true,
            'data' => $this->loadExpediente($folio),
        ]);
    }

    public function responderAutorizacion(Request $request, string $token): JsonResponse
    {
        $data = $request->validate([
            'aprueba' => 'required|boolean',
            'observacion' => 'nullable|string|max:1000',
        ]);

        $autorizacion = LicenciaPacienteAutorizacion::where('token', $token)->firstOrFail();
        $expediente = $this->workflow->autorizarPaciente($autorizacion, (bool) $data['aprueba'], $data['observacion'] ?? null);

        return response()->json([
            'ok' => true,
            'message' => $data['aprueba']
                ? 'Paciente autorizo. Empleador(es) notificado(s) para preparar documentacion.'
                : 'Paciente rechazo. No se enviara al empleador.',
            'data' => $expediente,
        ]);
    }

    public function empleadorPendientes(string $rut): JsonResponse
    {
        $rutClean = Rut::clean($rut);

        $empleadores = LicenciaEmpleador::with(['expediente.paciente', 'documentosRequeridos.adjuntos', 'notificaciones'])
            ->whereRaw("UPPER(REPLACE(REPLACE(REPLACE(rut, '.', ''), '-', ''), ' ', '')) = ?", [$rutClean])
            ->whereIn('estado', ['notificado_preparar_documentos', 'documentacion_en_preparacion'])
            ->orderByDesc('id')
            ->get()
            ->map(fn (LicenciaEmpleador $empleador) => $this->workflow->marcarConsultaEmpleador($empleador));

        return response()->json([
            'ok' => true,
            'data' => $empleadores,
        ]);
    }

    public function prepararDocumentacion(Request $request, int $empleadorId): JsonResponse
    {
        $empleador = LicenciaEmpleador::with('expediente')->findOrFail($empleadorId);
        $empleador->update([
            'estado' => 'documentacion_en_preparacion',
            'documentacion_preparada_at' => now(),
        ]);

        $this->workflow->evento($empleador->expediente, 'empleador', 'documentacion_en_preparacion', $empleador->razon_social);

        return response()->json([
            'ok' => true,
            'message' => 'Empleador marcado como preparando documentacion.',
            'data' => $empleador->fresh(['expediente', 'documentosRequeridos']),
        ]);
    }

    public function adjuntarDocumento(Request $request, int $documentoId): JsonResponse
    {
        $request->validate([
            'archivo' => 'required|file|max:10240',
        ]);

        $documento = LicenciaDocumentoRequerido::with('expediente')->findOrFail($documentoId);
        $file = $request->file('archivo');
        $path = $file->store('licencias/' . $documento->expediente->folio, 'public');

        $adjunto = $documento->adjuntos()->create([
            'archivo_path' => $path,
            'nombre_original' => $file->getClientOriginalName(),
            'mime' => $file->getMimeType(),
            'tamano' => $file->getSize(),
            'estado' => 'adjunto',
            'adjuntado_at' => now(),
        ]);

        $documento->update(['estado' => 'adjunto']);
        $this->workflow->evento($documento->expediente, 'empleador', 'documento_adjunto', $documento->nombre);

        return response()->json([
            'ok' => true,
            'data' => $adjunto,
        ], 201);
    }

    private function loadExpediente(string $folio): LicenciaExpediente
    {
        return LicenciaExpediente::with([
            'paciente',
            'profesional',
            'autorizacionPaciente',
            'empleadores.notificaciones',
            'documentosRequeridos.adjuntos',
            'eventos',
        ])->where('folio', $folio)->firstOrFail();
    }

    private function generarFolio(): string
    {
        do {
            $folio = 'LM-' . now()->format('Ymd') . '-' . Str::upper(Str::random(6));
        } while (LicenciaExpediente::where('folio', $folio)->exists());

        return $folio;
    }
}
