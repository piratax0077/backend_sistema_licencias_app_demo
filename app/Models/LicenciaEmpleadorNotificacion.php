<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class LicenciaEmpleadorNotificacion extends Model
{
    protected $table = 'licencia_empleador_notificaciones';

    protected $fillable = [
        'empleador_id',
        'canal',
        'destinatario',
        'estado',
        'asunto',
        'mensaje',
        'enviada_at',
    ];

    protected $casts = [
        'enviada_at' => 'datetime',
    ];

    public function empleador(): BelongsTo
    {
        return $this->belongsTo(LicenciaEmpleador::class, 'empleador_id');
    }
}
