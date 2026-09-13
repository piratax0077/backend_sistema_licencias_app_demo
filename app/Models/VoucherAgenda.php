<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class VoucherAgenda extends Model
{
    protected $table = 'voucher_agendas';

    protected $fillable = [
        'voucher_id',
        'cliente_id',
        'mascota_id',
        'profesional_id',
        'centro_atencion_id',
        'fecha_hora_solicitada',
        'fecha_hora_confirmada',
        'estado',
        'observacion',
    ];

    protected $dates = [
        'fecha_hora_solicitada',
        'fecha_hora_confirmada',
    ];

    public function voucher()
    {
        return $this->belongsTo(Voucher::class, 'voucher_id');
    }
}
