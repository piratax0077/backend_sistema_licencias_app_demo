<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TotemVenta extends Model
{
    protected $table = 'totem_ventas';

protected $fillable = [
    'totem_id',
    'cliente_id',
    'total',
    'estado',
    'medio_pago',
    'codigo_transaccion',
    'canal_entrega',
    'destino_entrega',
    'entregado_en',
    'cliente_rut',
    'cliente_nombre',
    'cliente_telefono',
    'cliente_email',
    'mascota_nombre',
    'mascota_edad',
    'mascota_raza',
    'prestador_tipo',
    'prestador_id',
    'prestador_nombre',
    'prestador_rut',
    'prestador_especialidad',
    'prestador_email',
    'prestador_telefono',
    'prestador_direccion',
    'valor_total',
    'copago_seguro',
    'copago_cliente',


];

    public function totem()
    {
        return $this->belongsTo(Totem::class);
    }

    public function detalles()
    {
        return $this->hasMany(TotemVentaDetalle::class, 'venta_id');
    }
}
