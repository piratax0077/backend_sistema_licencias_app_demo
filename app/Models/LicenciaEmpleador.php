<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class LicenciaEmpleador extends Model
{
    protected $table = 'licencia_empleadores';

    protected $fillable = [
        'expediente_id',
        'rut',
        'razon_social',
        'email',
        'telefono',
        'direccion',
        'afiliado_ccaf',
        'ccaf_nombre',
        'estado',
        'consultado_at',
        'notificado_at',
        'documentacion_preparada_at',
    ];

    protected $casts = [
        'afiliado_ccaf' => 'boolean',
        'consultado_at' => 'datetime',
        'notificado_at' => 'datetime',
        'documentacion_preparada_at' => 'datetime',
    ];

    public function expediente(): BelongsTo
    {
        return $this->belongsTo(LicenciaExpediente::class, 'expediente_id');
    }

    public function notificaciones(): HasMany
    {
        return $this->hasMany(LicenciaEmpleadorNotificacion::class, 'empleador_id');
    }

    public function documentosRequeridos(): HasMany
    {
        return $this->hasMany(LicenciaDocumentoRequerido::class, 'empleador_id');
    }
}
