<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class LicenciaDocumentoRequerido extends Model
{
    protected $table = 'licencia_documentos_requeridos';

    protected $fillable = [
        'expediente_id',
        'empleador_id',
        'codigo',
        'nombre',
        'descripcion',
        'obligatorio',
        'estado',
    ];

    protected $casts = [
        'obligatorio' => 'boolean',
    ];

    public function expediente(): BelongsTo
    {
        return $this->belongsTo(LicenciaExpediente::class, 'expediente_id');
    }

    public function empleador(): BelongsTo
    {
        return $this->belongsTo(LicenciaEmpleador::class, 'empleador_id');
    }

    public function adjuntos(): HasMany
    {
        return $this->hasMany(LicenciaDocumentoAdjunto::class, 'documento_requerido_id');
    }
}
