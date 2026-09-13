<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TotemSesion extends Model
{
    protected $table = 'totem_sesiones';

    protected $fillable = [
        'totem_id',
        'token',
        'inicio',
        'fin',
    ];

    public function totem()
    {
        return $this->belongsTo(Totem::class);
    }
}
