<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Api\LicenciaApiController;
use App\Models\LicenciaEmpleador;
use App\Models\LicenciaExpediente;
use App\Support\Rut;
use Illuminate\Http\Request;

class LicenciaWebController extends Controller
{
    public function index()
    {
        $expedientes = LicenciaExpediente::with(['paciente', 'empleadores', 'autorizacionPaciente'])
            ->orderByDesc('id')
            ->take(30)
            ->get();

        return view('licencia', compact('expedientes'));
    }

    public function store(Request $request, LicenciaApiController $api)
    {
        $empleadores = [];
        foreach (($request->input('empleadores', [])) as $empleador) {
            if (!empty($empleador['razon_social'])) {
                $empleadores[] = $empleador;
            }
        }

        $request->merge([
            'paciente' => [
                'rut' => Rut::format($request->input('paciente_rut')),
                'nombre' => $request->input('paciente_nombre'),
                'email' => $request->input('paciente_email'),
                'telefono' => $request->input('paciente_telefono'),
                'direccion' => $request->input('paciente_direccion'),
                'prevision' => $request->input('paciente_prevision'),
            ],
            'profesional' => [
                'rut' => Rut::format($request->input('profesional_rut')),
                'nombre' => $request->input('profesional_nombre'),
                'especialidad' => $request->input('profesional_especialidad'),
                'email' => $request->input('profesional_email'),
                'firma_hash' => $request->input('profesional_firma_hash'),
            ],
            'empleadores' => $empleadores,
        ]);

        $response = $api->emitir($request);
        $payload = $response->getData(true);

        return redirect('/licencia')
            ->with('ok', $payload['message'] ?? 'Licencia creada.')
            ->with('folio_creado', data_get($payload, 'data.folio'))
            ->with('token_autorizacion', data_get($payload, 'data.autorizacion_paciente.token'));
    }

    public function empleador(Request $request)
    {
        $rut = Rut::format($request->query('rut'));
        $pendientes = collect();

        if ($rut) {
            $pendientes = LicenciaEmpleador::with(['expediente.paciente', 'documentosRequeridos.adjuntos'])
                ->whereRaw("UPPER(REPLACE(REPLACE(REPLACE(rut, '.', ''), '-', ''), ' ', '')) = ?", [Rut::clean($rut)])
                ->whereIn('estado', ['notificado_preparar_documentos', 'documentacion_en_preparacion'])
                ->orderByDesc('id')
                ->get();
        }

        return view('empleador_pendientes', compact('rut', 'pendientes'));
    }
}
