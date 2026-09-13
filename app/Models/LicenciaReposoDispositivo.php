<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LicenciaReposoDispositivo extends Model
{
    protected $table = 'licencia_reposo_dispositivos';

    protected $fillable = [
        'paciente_rut',
        'device_token',
        'plataforma',
        'app_version',
        'ultimo_contacto_at',
    ];

    protected $casts = [
        'ultimo_contacto_at' => 'datetime',
    ];
}
