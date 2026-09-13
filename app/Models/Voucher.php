<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Crypt;

class Voucher extends Model
{
    use HasFactory;

    protected $fillable = [
        'codigo',
        'qr_token',
        'qr_firma',
        'qr_expira',
        'qr_usado',
        'qr_usado_at',
        'cliente_rut_hash',
        'vendedor_id',
        'cliente_id',
        'mascota_id',
        'criadero_cachorro_id',
        'cliente_rut',
        'cliente_nombre',
        'tipo_servicio',
        'valor',
        'porcentaje_descuento',
        'estado',
        'fecha_vencimiento',
        'usado_en',
        'copago_usuario',
        'saldo_veterinario',
        'comision_veterchile',
        'profesional_id',
        'servicio_id',
        'cliente_aceptado_en',
        'cliente_rechazado_en',
        'motivo_rechazo_cliente',
        'mascota_id',
        'otp_hash',
        'otp_expira',
        'otp_validado_at',
        'invalidado_en',
        'motivo_invalidacion',
        'copago_devuelto',
        'saldo_cliente_aplicado',
        'totem_venta_id',
        'mascota_nombre',
        'mascota_edad',
        'mascota_raza',

        'prestador_rut',
        'prestador_nombre',
        'prestador_especialidad',
        'prestador_email',
        'prestador_telefono',
        'prestador_direccion',

        'valor_total',



    ];
    public function cobros()
    {
        return $this->hasMany(VoucherCobro::class);
    }
    public function pagos()
{
    return $this->hasMany(\App\Models\VoucherPago::class);
}
public function vendedor()
{
    return $this->belongsTo(
        \App\Models\VoucherVendedor::class,
        'vendedor_id'
    );
}
public function profesional()
{
    return $this->belongsTo(
        \App\Models\VoucherProfesional::class,
        'profesional_id'
    );
}
public function servicio()
{
    return $this->belongsTo(\App\Models\VoucherServicio::class, 'servicio_id');
}
public function mascota()
{
    return $this->belongsTo(
        \App\Models\VoucherMascota::class,
        'mascota_id'
    );
}
public function getClienteRutVisibleAttribute()
{
    try {
        return Crypt::decryptString($this->cliente_rut);
    } catch (\Exception $e) {
        return $this->cliente_rut;
    }
}
public function agenda()
{
    return $this->hasOne(\App\Models\VoucherAgenda::class, 'voucher_id');
}

public function atencion()
{
    return $this->hasOne(\App\Models\VoucherAtencion::class, 'voucher_id');
}
}
