<?php

namespace App\Http\Controllers\Api\Totem;

use App\Http\Controllers\Controller;
use App\Models\TotemLog;
use App\Models\TotemVenta;
use App\Models\TotemVentaDetalle;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class VentaTotemController extends Controller
{
    public function crear(Request $request)
    {
        $request->validate([
            'items' => 'required|array|min:1',
            'items.*.tipo' => 'required|string|in:voucher,alimentos,juguetes,planes,producto,servicio',
            'items.*.referencia_id' => 'required|integer',
            'items.*.cantidad' => 'required|integer|min:1',
            'items.*.precio' => 'required|numeric|min:0',

            'medio_pago' => 'nullable|string|max:50',

            'cliente_id' => 'nullable|integer',
            'cliente_rut' => 'nullable|string|max:30',
            'cliente_nombre' => 'nullable|string|max:150',
            'cliente_telefono' => 'nullable|string|max:50',
            'cliente_email' => 'nullable|email|max:150',

            'prestador_tipo' => 'nullable|string|in:veterinario,farmacia,alimentos,petshop',
            'prestador_id' => 'nullable|integer',
            'prestador_nombre' => 'nullable|string|max:150',
            'prestador_rut' => 'nullable|string|max:30',
            'prestador_especialidad' => 'nullable|string|max:150',
            'prestador_email' => 'nullable|email|max:150',
            'prestador_telefono' => 'nullable|string|max:50',
            'prestador_direccion' => 'nullable|string|max:255',

            'mascota_nombre' => 'nullable|string|max:100',
            'mascota_edad' => 'nullable|integer|min:0|max:80',
            'mascota_raza' => 'nullable|string|max:100',

            'valor_total' => 'nullable|numeric|min:0',
            'copago_seguro' => 'nullable|numeric|min:0',
            'copago_cliente' => 'nullable|numeric|min:0',
        ]);

        $totem = $request->get('totem');

        if (!$totem) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'Tótem no autenticado',
            ], 401);
        }

        $venta = DB::transaction(function () use ($request, $totem) {
            $items = collect($request->input('items', []));

            $total = $items->sum(function ($item) {
                return ((int) $item['cantidad']) * ((float) $item['precio']);
            });

            $valorTotal = $request->filled('valor_total')
                ? (float) $request->valor_total
                : (float) $total;

            $copagoSeguro = $request->filled('copago_seguro')
                ? (float) $request->copago_seguro
                : 0;

            $copagoCliente = $request->filled('copago_cliente')
                ? (float) $request->copago_cliente
                : max($valorTotal - $copagoSeguro, 0);

            $venta = TotemVenta::create([
                'totem_id' => $totem->id,
                'cliente_id' => $request->cliente_id,
                'total' => $total,
                'estado' => 'pendiente',
                'medio_pago' => $request->medio_pago,

                'cliente_rut' => $request->cliente_rut,
                'cliente_nombre' => $request->cliente_nombre ?: 'Invitado',
                'cliente_telefono' => $request->cliente_telefono,
                'cliente_email' => $request->cliente_email,

                'prestador_tipo' => $request->prestador_tipo,
                'prestador_id' => $request->prestador_id,
                'prestador_nombre' => $request->prestador_nombre,
                'prestador_rut' => $request->prestador_rut,
                'prestador_especialidad' => $request->prestador_especialidad,
                'prestador_email' => $request->prestador_email,
                'prestador_telefono' => $request->prestador_telefono,
                'prestador_direccion' => $request->prestador_direccion,

                'mascota_nombre' => $request->mascota_nombre,
                'mascota_edad' => $request->mascota_edad,
                'mascota_raza' => $request->mascota_raza,

                'valor_total' => $valorTotal,
                'copago_seguro' => $copagoSeguro,
                'copago_cliente' => $copagoCliente,
            ]);

            foreach ($items as $item) {
                TotemVentaDetalle::create([
                    'venta_id' => $venta->id,
                    'tipo' => $item['tipo'],
                    'referencia_id' => $item['referencia_id'],
                    'cantidad' => (int) $item['cantidad'],
                    'precio' => (float) $item['precio'],
                ]);
            }

            TotemLog::create([
                'totem_id' => $totem->id,
                'evento' => 'venta_creada',
                'detalle' => 'Venta creada desde tótem ID '.$venta->id,
                'ip' => $request->ip(),
            ]);

            return $venta->load('detalles');
        });

        return response()->json([
            'ok' => true,
            'venta_id' => $venta->id,
            'estado' => $venta->estado,
            'total' => $venta->total,
            'valor_total' => $venta->valor_total,
            'copago_seguro' => $venta->copago_seguro,
            'copago_cliente' => $venta->copago_cliente,
            'prestador_nombre' => $venta->prestador_nombre,
            'cliente_nombre' => $venta->cliente_nombre,
            'items' => $venta->detalles,
        ]);
    }
}

