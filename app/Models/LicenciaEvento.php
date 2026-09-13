<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class LicenciaEvento extends Model
{
    protected $table = 'licencia_eventos';

    protected $fillable = [
        'expediente_id',
        'actor',
        'accion',
        'detalle',
        'metadata',
    ];

    protected $casts = [
        'metadata' => 'array',
    ];

    public function expediente(): BelongsTo
    {
        return $this->belongsTo(LicenciaExpediente::class, 'expediente_id');
    }
}
