<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class LicenciaPacienteAutorizacion extends Model
{
    protected $table = 'licencia_paciente_autorizaciones';

    protected $fillable = [
        'expediente_id',
        'token',
        'canal',
        'estado',
        'solicitada_at',
        'respondida_at',
        'respuesta_observacion',
        'payload_app',
    ];

    protected $casts = [
        'solicitada_at' => 'datetime',
        'respondida_at' => 'datetime',
        'payload_app' => 'array',
    ];

    public function expediente(): BelongsTo
    {
        return $this->belongsTo(LicenciaExpediente::class, 'expediente_id');
    }
}
