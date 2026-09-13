<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class LicenciaPaciente extends Model
{
    protected $table = 'licencia_pacientes';

    protected $fillable = [
        'expediente_id',
        'rut',
        'nombre',
        'email',
        'telefono',
        'direccion',
        'prevision',
    ];

    public function expediente(): BelongsTo
    {
        return $this->belongsTo(LicenciaExpediente::class, 'expediente_id');
    }
}
