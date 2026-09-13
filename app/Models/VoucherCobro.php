<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VoucherCobro extends Model
{
    use HasFactory;
        protected $fillable = [
            'voucher_id',
            'profesional_id',
            'voucher_rendicion_id',
            'veterinario_id',
            'veterinario_nombre',
            'sucursal',
            'monto_cobrado',
            'estado',
            'cobrado_en',
        ];

    // public function voucher()
    // {
    //     return $this->belongsTo(Voucher::class);
    // }
    public function voucher()
    {
    return $this->belongsTo(\App\Models\Voucher::class, 'voucher_id');
    }
    public function rendicion()
    {
        return $this->belongsTo(\App\Models\VoucherRendicion::class, 'voucher_rendicion_id');
    }

}
