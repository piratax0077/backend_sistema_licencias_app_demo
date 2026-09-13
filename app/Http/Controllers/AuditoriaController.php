<?php

namespace App\Http\Controllers;

use App\Models\Voucher;
use App\Models\VoucherAlerta;
use App\Models\VoucherAuditoria;

class AuditoriaController extends Controller
{
    public function index()
    {
        $auditorias = VoucherAuditoria::with('voucher')
            ->orderBy('id', 'desc')
            ->get();

        return view('auditoria.index', compact('auditorias'));
    }

    public function alertas()
    {
        $verdes = VoucherAlerta::where('nivel', 'verde')->count();

        $amarillas = VoucherAlerta::where('nivel', 'amarillo')->count();

        $rojas = VoucherAlerta::where('nivel', 'rojo')->count();

        $montoBloqueado = Voucher::whereIn(
            'id',
            VoucherAlerta::where('nivel', 'rojo')
                ->where('resuelta', 0)
                ->pluck('voucher_id')
        )->sum('saldo_veterinario');

       $alertas = VoucherAlerta::with('voucher')
            ->orderBy('id', 'desc')
            ->get();

        $alertasPorTipo = VoucherAlerta::selectRaw('tipo_alerta, count(*) as total')
            ->groupBy('tipo_alerta')
            ->get();

        $alertasPorNivel = VoucherAlerta::selectRaw('nivel, count(*) as total')
            ->groupBy('nivel')
            ->get();

        return view('admin.alertas', compact(
            'alertas',
            'alertasPorTipo',
            'alertasPorNivel'
        ));

        $topProfesionales = VoucherAlerta::join(
                'vouchers',
                'voucher_alertas.voucher_id',
                '=',
                'vouchers.id'
            )
            ->selectRaw('vouchers.profesional_id, COUNT(*) as total')
            ->groupBy('vouchers.profesional_id')
            ->orderByDesc('total')
            ->take(10)
            ->get();

        return view('admin.alertas', compact(
            'verdes',
            'amarillas',
            'rojas',
            'montoBloqueado',
            'alertas',
            'topProfesionales'
        ));
    }

    public function resolver($id)
    {
        $alerta = VoucherAlerta::findOrFail($id);
        $alerta = VoucherAlerta::create([
        'voucher_id' => $voucher->id,
        'tipo_alerta' => 'invalidacion_copago_alto',
        'nivel' => 'rojo',
        'descripcion' => 'Cliente invalidó voucher con copago alto',
            ]);
        AuditorNotificacion::create([
            'voucher_id' => $voucher->id,
            'alerta_id' => $alerta->id,
            'titulo' => 'Invalidación con copago alto',
            'mensaje' => 'El voucher '.$voucher->codigo.
                        ' fue invalidado y requiere revisión del auditor.',
        ]);

        $alerta->update([
            'resuelta' => true,
        ]);

        return back();
    }
}
