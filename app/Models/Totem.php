<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Totem extends Model
{
    protected $fillable = [
        'codigo',
        'nombre',
        'ubicacion',
        'ip_autorizada',
        'serial',
        'version',
        'token',
        'activo',
        'ultimo_acceso',
        'ultimo_ping',
    ];

    public function sesiones()
    {
        return $this->hasMany(TotemSesion::class);
    }

    public function ventas()
    {
        return $this->hasMany(TotemVenta::class);
    }

    public function logs()
    {
        return $this->hasMany(TotemLog::class);
    }
}
