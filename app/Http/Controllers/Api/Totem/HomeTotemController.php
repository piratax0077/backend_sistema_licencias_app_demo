<?php

namespace App\Http\Controllers\Api\Totem;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Campana;

class HomeTotemController extends Controller
{
    public function index(Request $request)
    {
        $totem = $request->get('totem');

        return response()->json([
            'ok' => true,

            'totem' => [
                'id' => $totem->id,
                'codigo' => $totem->codigo,
                'nombre' => $totem->nombre,
                'ubicacion' => $totem->ubicacion,
                'version' => $totem->version,
            ],

            'categorias' => [
                [
                    'id' => 1,
                    'nombre' => 'Vouchers',
                    'slug' => 'voucher',
                ],
                [
                    'id' => 2,
                    'nombre' => 'Alimentos',
                    'slug' => 'alimentos',
                ],
                [
                    'id' => 3,
                    'nombre' => 'Juguetes',
                    'slug' => 'juguetes',
                ],
                [
                    'id' => 4,
                    'nombre' => 'Planes Mensuales',
                    'slug' => 'planes',
                ],
            ],

            'prestadores' => [
                [
                    'id' => 1,
                    'tipo' => 'veterinario',
                    'nombre' => 'Veterinaria Demo',
                ],
                [
                    'id' => 2,
                    'tipo' => 'farmacia',
                    'nombre' => 'Farmacia VeterChile',
                ],
                [
                    'id' => 3,
                    'tipo' => 'alimentos',
                    'nombre' => 'Alimentos Vet',
                ],
            ],

            'opciones_entrega' => [
                'app',
                'whatsapp',
                'email',
                'veterinario',
                'impresion',
            ],

            'campanas' => Campana::where('activa', true)
                ->get([
                    'id',
                    'nombre',
                    'descripcion'
                ]),
        ]);
    }
}
