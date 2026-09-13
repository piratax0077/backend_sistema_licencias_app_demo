<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class LicenciaDocumentoAdjunto extends Model
{
    protected $table = 'licencia_documentos_adjuntos';

    protected $fillable = [
        'documento_requerido_id',
        'archivo_path',
        'nombre_original',
        'mime',
        'tamano',
        'estado',
        'adjuntado_at',
    ];

    protected $casts = [
        'adjuntado_at' => 'datetime',
    ];

    public function documentoRequerido(): BelongsTo
    {
        return $this->belongsTo(LicenciaDocumentoRequerido::class, 'documento_requerido_id');
    }
}
