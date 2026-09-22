<?php

namespace App\Services;

use App\Models\LicenciaDocumentoRequerido;
use App\Models\LicenciaEmpleador;
use App\Models\LicenciaEmpleadorNotificacion;
use App\Models\LicenciaEvento;
use App\Models\LicenciaExpediente;
use App\Models\LicenciaPacienteAutorizacion;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class LicenciaWorkflowService
{
    public const ESTADO_PENDIENTE_AUTORIZACION = 'pendiente_autorizacion_paciente';
    public const ESTADO_AUTORIZADA_PACIENTE = 'autorizada_paciente';
    public const ESTADO_ENVIADA_EMPLEADOR = 'enviada_empleador';

    public function crearAutorizacionPaciente(LicenciaExpediente $expediente): LicenciaPacienteAutorizacion
    {
        $token = 'LIC-' . Str::upper(Str::random(48));

        return $expediente->autorizacionPaciente()->create([
            'token' => $token,
            'canal' => 'app_licencias_reposo',
            'estado' => 'pendiente',
            'solicitada_at' => now(),
            'payload_app' => $this->payloadApp($expediente, $token),
        ]);
    }

    public function crearSolicitudFiscalizacion(LicenciaExpediente $expediente): LicenciaPacienteAutorizacion
    {
        $token = 'FIS-' . Str::upper(Str::random(48));
        $payload = $this->payloadApp($expediente, $token);
        $payload['alcances'] = [
            'antecedentes' => true,
            'ubicacion' => true,
            'camara' => true,
        ];
        $payload['mensaje'] = 'Fiscalización solicita decisiones independientes para antecedentes, ubicación y cámara.';

        return $expediente->autorizacionPaciente()->create([
            'token' => $token,
            'canal' => 'fiscalizacion_reposo',
            'estado' => 'pendiente',
            'solicitada_at' => now(),
            'payload_app' => $payload,
        ]);
    }

    public function responderFiscalizacion(LicenciaPacienteAutorizacion $autorizacion, array $decisiones, ?string $observacion = null): LicenciaExpediente
    {
        return DB::transaction(function () use ($autorizacion, $decisiones, $observacion) {
            $expediente = $autorizacion->expediente()->lockForUpdate()->firstOrFail();
            $normalizadas = [
                'antecedentes' => (bool) ($decisiones['antecedentes'] ?? false),
                'ubicacion' => (bool) ($decisiones['ubicacion'] ?? false),
                'camara' => (bool) ($decisiones['camara'] ?? false),
            ];
            $aprobadas = count(array_filter($normalizadas));
            $estado = $aprobadas === 3 ? 'aprobada' : ($aprobadas === 0 ? 'rechazada' : 'parcial');
            $payload = $autorizacion->payload_app ?: [];
            $payload['decisiones'] = $normalizadas;
            $payload['respondida_at'] = now()->toISOString();

            $autorizacion->update([
                'estado' => $estado,
                'respondida_at' => now(),
                'respuesta_observacion' => $observacion,
                'payload_app' => $payload,
            ]);
            $expediente->update(['estado' => 'fiscalizacion_' . $estado]);
            $this->evento($expediente, 'paciente', 'paciente_responde_fiscalizacion', $observacion, ['decisiones' => $normalizadas]);

            return $expediente->fresh(['paciente', 'profesional', 'autorizacionPaciente']);
        });
    }

    public function crearDocumentosBase(LicenciaExpediente $expediente, ?LicenciaEmpleador $empleador = null): void
    {
        $docs = [
            [
                'codigo' => 'formulario_empleador',
                'nombre' => 'Formulario empleador Fonasa',
                'descripcion' => 'Formulario editable generado desde licencias/LISTOS/informacion_tramitacion_lm_trabajador_fonasa.blade.php',
            ],
            [
                'codigo' => 'cotizaciones_6_meses',
                'nombre' => 'Certificado de cotizaciones AFP y salud',
                'descripcion' => 'Cotizaciones previsionales de los ultimos 6 meses anteriores al inicio del reposo.',
            ],
            [
                'codigo' => 'contrato_trabajo',
                'nombre' => 'Contrato de trabajo vigente',
                'descripcion' => 'Copia del contrato de trabajo o anexo vigente.',
            ],
            [
                'codigo' => 'informe_licencias_previas',
                'nombre' => 'Informe licencias medicas previas',
                'descripcion' => 'Informe de licencias medicas de los ultimos 6 meses si el trabajador tuvo alguna.',
            ],
            [
                'codigo' => 'liquidaciones_3_meses',
                'nombre' => 'Ultimas 3 liquidaciones de sueldo',
                'descripcion' => 'Liquidaciones anteriores al inicio de la licencia, segun tabla explicativa.',
            ],
        ];

        foreach ($docs as $doc) {
            LicenciaDocumentoRequerido::firstOrCreate([
                'expediente_id' => $expediente->id,
                'empleador_id' => $empleador?->id,
                'codigo' => $doc['codigo'],
            ], [
                'nombre' => $doc['nombre'],
                'descripcion' => $doc['descripcion'],
                'obligatorio' => true,
                'estado' => 'pendiente',
            ]);
        }
    }

    public function autorizarPaciente(LicenciaPacienteAutorizacion $autorizacion, bool $aprueba, ?string $observacion = null): LicenciaExpediente
    {
        return DB::transaction(function () use ($autorizacion, $aprueba, $observacion) {
            $expediente = $autorizacion->expediente()->lockForUpdate()->firstOrFail();

            $autorizacion->update([
                'estado' => $aprueba ? 'aprobada' : 'rechazada',
                'respondida_at' => now(),
                'respuesta_observacion' => $observacion,
            ]);

            $expediente->update([
                'estado' => $aprueba ? self::ESTADO_AUTORIZADA_PACIENTE : 'rechazada_por_paciente',
            ]);

            $this->evento($expediente, 'paciente', $aprueba ? 'paciente_autoriza' : 'paciente_rechaza', $observacion);

            if ($aprueba) {
                $this->notificarEmpleadores($expediente);
            }

            return $expediente->fresh([
                'paciente',
                'profesional',
                'autorizacionPaciente',
                'empleadores.notificaciones',
                'documentosRequeridos',
            ]);
        });
    }

    public function notificarEmpleadores(LicenciaExpediente $expediente): void
    {
        foreach ($expediente->empleadores as $empleador) {
            $empleador->update([
                'estado' => 'notificado_preparar_documentos',
                'notificado_at' => now(),
            ]);

            LicenciaEmpleadorNotificacion::create([
                'empleador_id' => $empleador->id,
                'canal' => $empleador->email ? 'email' : 'api',
                'destinatario' => $empleador->email ?: $empleador->rut ?: 'empleador_sin_contacto',
                'estado' => 'enviada',
                'asunto' => 'Preparar documentacion licencia medica ' . $expediente->folio,
                'mensaje' => 'El paciente autorizo el envio. Debe preparar formulario empleador, cotizaciones, contrato, licencias previas si corresponden y ultimas 3 liquidaciones.',
                'enviada_at' => now(),
            ]);

            $this->crearDocumentosBase($expediente, $empleador);
        }

        $expediente->update(['estado' => self::ESTADO_ENVIADA_EMPLEADOR]);
        $this->evento($expediente, 'sistema', 'empleadores_notificados', 'Se notifico a empleador(es) para preparar documentacion.');
    }

    public function marcarConsultaEmpleador(LicenciaEmpleador $empleador): LicenciaEmpleador
    {
        if (!$empleador->consultado_at) {
            $empleador->update(['consultado_at' => now()]);
        }

        $this->evento($empleador->expediente, 'empleador', 'empleador_consulta_expediente', $empleador->razon_social);

        return $empleador->fresh(['expediente.paciente', 'documentosRequeridos.adjuntos', 'notificaciones']);
    }

    public function evento(LicenciaExpediente $expediente, ?string $actor, string $accion, ?string $detalle = null, array $metadata = []): void
    {
        LicenciaEvento::create([
            'expediente_id' => $expediente->id,
            'actor' => $actor,
            'accion' => $accion,
            'detalle' => $detalle,
            'metadata' => $metadata ?: null,
        ]);
    }

    private function payloadApp(LicenciaExpediente $expediente, string $token): array
    {
        $expediente->loadMissing(['paciente', 'profesional']);

        return [
            'token' => $token,
            'folio' => $expediente->folio,
            'estado' => $expediente->estado,
            'tipo_licencia' => $expediente->tipo_licencia,
            'dias_reposo' => $expediente->dias_reposo,
            'fecha_inicio_reposo' => optional($expediente->fecha_inicio_reposo)->toDateString(),
            'fecha_fin_reposo' => optional($expediente->fecha_fin_reposo)->toDateString(),
            'paciente' => [
                'rut' => optional($expediente->paciente)->rut,
                'nombre' => optional($expediente->paciente)->nombre,
            ],
            'profesional' => [
                'rut' => optional($expediente->profesional)->rut,
                'nombre' => optional($expediente->profesional)->nombre,
                'especialidad' => optional($expediente->profesional)->especialidad,
            ],
            'mensaje' => 'Autoriza que esta licencia sea enviada a su empleador para preparar documentacion.',
        ];
    }
}
