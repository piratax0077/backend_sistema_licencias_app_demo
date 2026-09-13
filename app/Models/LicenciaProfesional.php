<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class LicenciaProfesional extends Model
{
    protected $table = 'licencia_profesionales';

    protected $fillable = [
        'expediente_id',
        'rut',
        'nombre',
        'especialidad',
        'email',
        'firma_hash',
        'emitida_at',
    ];

    protected $casts = [
        'emitida_at' => 'datetime',
    ];

    public function expediente(): BelongsTo
    {
        return $this->belongsTo(LicenciaExpediente::class, 'expediente_id');
    }
}
