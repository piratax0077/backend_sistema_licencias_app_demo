<?php

namespace App\Http\Controllers\Api\Totem;

use App\Http\Controllers\Controller;
use App\Models\TotemVenta;
use App\Models\Voucher;
use Illuminate\Http\Request;

class TicketTotemController extends Controller
{
    public function ticket(Request $request, $id)
    {
        $totem = $request->get('totem');

        if (!$totem) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'Tótem no autenticado',
            ], 401);
        }

        $venta = TotemVenta::where('id', $id)
            ->where('totem_id', $totem->id)
            ->first();

        if (!$venta) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'Venta no encontrada para este tótem',
            ], 404);
        }

        $voucher = Voucher::where('totem_venta_id', $venta->id)
            ->latest()
            ->first();

        if (!$voucher) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'La venta aún no tiene voucher generado',
                'venta' => [
                    'id' => $venta->id,
                    'total' => $venta->total,
                    'estado' => $venta->estado,
                ],
            ], 404);
        }

        return response()->json([
            'ok' => true,
            'venta' => [
                'id' => $venta->id,
                'total' => $venta->total,
                'estado' => $venta->estado,
                'medio_pago' => $venta->medio_pago,
                'codigo_transaccion' => $venta->codigo_transaccion,
                'cliente_nombre' => $venta->cliente_nombre,
                'cliente_rut' => $venta->cliente_rut,
                'prestador_nombre' => $venta->prestador_nombre,
            ],
            'voucher' => [
                'id' => $voucher->id,
                'codigo' => $voucher->codigo,
                'qr_token' => $voucher->qr_token,
                'qr_url' => url('/api/vouchers/'.$voucher->qr_token.'/validar'),
                'valor' => $voucher->valor,
              'vence' => $voucher->fecha_vencimiento ? date('Y-m-d', strtotime($voucher->fecha_vencimiento)) : null,
'fecha_vencimiento' => $voucher->fecha_vencimiento ? date('Y-m-d', strtotime($voucher->fecha_vencimiento)) : null,
'qr_expira' => $voucher->qr_expira ? date('Y-m-d', strtotime($voucher->qr_expira)) : null,
                'estado' => $voucher->estado,

                'cliente_id' => $voucher->cliente_id,
                'cliente_rut' => $voucher->cliente_rut,
                'cliente_nombre' => $voucher->cliente_nombre,

                'mascota_nombre' => $voucher->mascota_nombre,
                'mascota_edad' => $voucher->mascota_edad,
                'mascota_raza' => $voucher->mascota_raza,

                'prestador_nombre' => $voucher->prestador_nombre,
                'prestador_rut' => $voucher->prestador_rut,
                'prestador_especialidad' => $voucher->prestador_especialidad,
                'prestador_email' => $voucher->prestador_email,
                'prestador_telefono' => $voucher->prestador_telefono,
                'prestador_direccion' => $voucher->prestador_direccion,

                'valor_total' => $voucher->valor_total ?? $voucher->valor,
                'copago_cliente' => $voucher->copago_usuario ?? 0,
                'copago_seguro' => $voucher->saldo_veterinario ?? 0,
            ],
        ]);
    }
}
