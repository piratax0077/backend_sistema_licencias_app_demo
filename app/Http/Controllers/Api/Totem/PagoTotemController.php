<?php

namespace App\Http\Controllers\Api\Totem;

use App\Http\Controllers\Controller;
use App\Models\TotemLog;
use App\Models\TotemVenta;
use App\Models\Voucher;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;

class PagoTotemController extends Controller
{
    public function confirmar(Request $request)
    {
        $request->validate([
            'venta_id' => 'required|integer',
            'codigo_transaccion' => 'required|string|max:100',
            'medio_pago' => 'required|string|max:50',
        ]);

        $totem = $request->get('totem');

        if (!$totem) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'Tótem no autenticado',
            ], 401);
        }

        return DB::transaction(function () use ($request, $totem) {

            $venta = TotemVenta::with('detalles')
                ->where('id', $request->venta_id)
                ->where('totem_id', $totem->id)
                ->lockForUpdate()
                ->first();

            if (!$venta) {
                return response()->json([
                    'ok' => false,
                    'mensaje' => 'Venta no encontrada para este tótem',
                ], 404);
            }

            if ($venta->estado === 'pagado') {
                return response()->json([
                    'ok' => false,
                    'mensaje' => 'La venta ya está pagada',
                ], 409);
            }

            if ($venta->detalles->isEmpty()) {
                return response()->json([
                    'ok' => false,
                    'mensaje' => 'La venta no tiene productos o vouchers asociados',
                ], 422);
            }

            $venta->update([
                'estado' => 'pagado',
                'medio_pago' => $request->medio_pago,
                'codigo_transaccion' => $request->codigo_transaccion,
            ]);

            $vouchersGenerados = [];

            foreach ($venta->detalles as $detalle) {
                if ($detalle->tipo !== 'voucher') {
                    continue;
                }

                $codigo = $this->generarCodigoVoucher();
                $qrToken = (string) Str::uuid();

                $dataVoucher = [
                    'totem_venta_id' => $venta->id,
                    'codigo' => $codigo,
                    'qr_token' => $qrToken,
                    'valor' => $detalle->precio,
                    'porcentaje_descuento' => 100,
                    'estado' => 'activo',
                    'fecha_vencimiento' => now()->addDays(30),
                    'tipo_servicio' => 'Voucher Tótem',
                    'cliente_id' => $venta->cliente_id,
                    'cliente_rut' => $venta->cliente_rut,
                    'cliente_nombre' => $venta->cliente_nombre ?: 'Invitado',
                    'qr_expira' => now()->addDays(30),
                    'qr_usado' => 0,
                    'mascota_nombre' => $venta->mascota_nombre,
                    'mascota_edad' => $venta->mascota_edad,
                    'mascota_raza' => $venta->mascota_raza,
                    'prestador_rut' => $venta->prestador_rut,
                    'prestador_nombre' => $venta->prestador_nombre,
                    'prestador_especialidad' => $venta->prestador_especialidad,
                    'prestador_email' => $venta->prestador_email,
                    'prestador_telefono' => $venta->prestador_telefono,
                    'prestador_direccion' => $venta->prestador_direccion,
                    'valor_total' => $venta->valor_total ?: $detalle->precio,
                    'copago_usuario' => $venta->copago_cliente ?: 0,
                    'saldo_veterinario' => $venta->copago_seguro ?: 0,
                ];

                if ($venta->prestador_tipo === 'veterinario') {
                    $dataVoucher['profesional_id'] = $venta->prestador_id;
                }

                if (in_array($venta->prestador_tipo, ['farmacia', 'alimentos', 'petshop'], true)) {
                    $dataVoucher['vendedor_id'] = $venta->prestador_id;
                }

                $voucher = Voucher::create($dataVoucher);

                $vouchersGenerados[] = [
                    'id' => $voucher->id,
                    'codigo' => $voucher->codigo,
                    'qr_token' => $voucher->qr_token,
                    'valor' => $voucher->valor,
                    'vence' => optional($voucher->fecha_vencimiento)->format('Y-m-d'),
                    'cliente_id' => $venta->cliente_id,
                    'cliente_rut' => $venta->cliente_rut,
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
                    'valor_total' => $voucher->valor_total,
                    'copago_cliente' => $voucher->copago_usuario,
                    'copago_seguro' => $voucher->saldo_veterinario,
                ];
            }

            TotemLog::create([
                'totem_id' => $totem->id,
                'evento' => 'pago_confirmado',
                'detalle' => 'Pago confirmado venta ID ' . $venta->id . ' con ' . count($vouchersGenerados) . ' voucher(s) generado(s)',
                'ip' => $request->ip(),
            ]);

            return response()->json([
                'ok' => true,
                'venta_id' => $venta->id,
                'estado' => $venta->fresh()->estado,
                'total' => $venta->total,
                'codigo_transaccion' => $venta->codigo_transaccion,
                'vouchers' => $vouchersGenerados,
            ]);
        });
    }

    private function generarCodigoVoucher(): string
    {
        do {
            $codigo = 'VT-' . now()->format('YmdHis') . '-' . strtoupper(Str::random(5));
        } while (Voucher::where('codigo', $codigo)->exists());

        return $codigo;
    }
}

