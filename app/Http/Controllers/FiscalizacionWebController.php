<?php

namespace App\Http\Controllers;

use App\Models\LicenciaExpediente;
use App\Models\LicenciaPacienteAutorizacion;
use App\Services\LicenciaWorkflowService;
use App\Support\Rut;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class FiscalizacionWebController extends Controller
{
    public function index()
    {
        $solicitudes = LicenciaPacienteAutorizacion::with(['expediente.paciente', 'expediente.profesional'])
            ->where('canal', 'fiscalizacion_reposo')
            ->orderByDesc('id')
            ->take(50)
            ->get();

        return view('fiscalizacion', compact('solicitudes'));
    }

    public function store(Request $request, LicenciaWorkflowService $workflow)
    {
        $data = $request->validate([
            'folio' => 'nullable|string|max:80|unique:licencia_expedientes,folio',
            'paciente_rut' => 'required|string|max:20',
            'paciente_nombre' => 'required|string|max:255',
            'dias_reposo' => 'required|integer|min:1|max:365',
            'fecha_inicio_reposo' => 'nullable|date',
            'motivo' => 'nullable|string|max:500',
        ]);

        $autorizacion = DB::transaction(function () use ($data, $workflow) {
            $expediente = LicenciaExpediente::create([
                'folio' => $data['folio'] ?: 'FIS-' . now()->format('Ymd-His') . '-' . Str::upper(Str::random(4)),
                'estado' => 'pendiente_fiscalizacion_paciente',
                'origen' => 'fiscalizacion_web',
                'tipo_licencia' => 'Fiscalización de reposo',
                'dias_reposo' => $data['dias_reposo'],
                'fecha_emision' => now()->toDateString(),
                'fecha_inicio_reposo' => $data['fecha_inicio_reposo'] ?: now()->toDateString(),
                'diagnostico_descripcion' => $data['motivo'] ?? null,
            ]);
            $expediente->paciente()->create([
                'rut' => Rut::format($data['paciente_rut']),
                'nombre' => $data['paciente_nombre'],
            ]);
            $expediente->profesional()->create([
                'nombre' => 'Unidad de Fiscalización',
                'especialidad' => 'Control de reposo',
                'emitida_at' => now(),
            ]);
            $autorizacion = $workflow->crearSolicitudFiscalizacion($expediente);
            $workflow->evento($expediente, 'fiscalizacion', 'solicitud_fiscalizacion_enviada', 'Se solicitaron tres permisos independientes al paciente.');
            return $autorizacion;
        });

        return redirect()->route('fiscalizacion.index')->with('ok', 'Solicitud enviada a la app del paciente: ' . $autorizacion->token);
    }
}
