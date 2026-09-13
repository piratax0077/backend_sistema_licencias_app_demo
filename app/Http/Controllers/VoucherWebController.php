<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Crypt;
use App\Models\Voucher;
use App\Models\VoucherProfesional;
use App\Models\VoucherAuditoria;
use App\Models\VoucherServicio;
use App\Models\ClienteSaldo;
use App\Models\AuditorNotificacion;



class VoucherWebController extends Controller
{
    public function index()
    {
        if (!auth()->check()) {
            abort(403);
        }

        if (auth()->user()->rol == 'admin') {
            $vouchers = Voucher::orderBy('id', 'desc')->get();
        } elseif (auth()->user()->rol == 'vendedor') {
            $vouchers = Voucher::where('vendedor_id', auth()->user()->vendedor_id)
                ->orderBy('id', 'desc')
                ->get();
        } elseif (auth()->user()->rol == 'profesional') {
            $vouchers = Voucher::where('profesional_id', auth()->user()->profesional_id)
                ->orderBy('id', 'desc')
                ->get();
        } else {
            abort(403);
        }

        return view('vouchers.index', compact('vouchers'));
    }

    public function create()
    {
        if (!auth()->check() || auth()->user()->rol != 'vendedor') {
            abort(403, 'Solo vendedores pueden emitir vouchers');
        }

        return view('vouchers.create');
    }

    public function store(Request $request)
    {
        if (!auth()->check() || auth()->user()->rol != 'vendedor') {
            abort(403, 'Solo vendedores pueden emitir vouchers');
        }

        $request->validate([
            'cliente_nombre' => 'required',
            'cliente_rut' => 'required',
            'cliente_telefono' => 'required',
            'servicio_id' => 'required',
        ]);

        $servicio = VoucherServicio::findOrFail($request->servicio_id);

        $valor = $servicio->valor_base;
        $copago = $servicio->copago_base;
        $saldoAplicado = min($saldoDisponible, $copago);
        $copagoFinal = $copago - $saldoAplicado;
        $comision = $servicio->comision_veterchile;
        $saldoVeterinario = $valor - $copago - $comision;

        $rutNormalizado = strtoupper(trim($request->cliente_rut));
        $rutHash = hash('sha256', $rutNormalizado);
        $saldoDisponible = ClienteSaldo::where('cliente_rut_hash', $rutHash)
        ->where('estado', 'disponible')
        ->sum('monto');
        $rutCifrado = Crypt::encryptString($rutNormalizado);
        $invalidacionesVendedor = Voucher::where('vendedor_id', auth()->user()->vendedor_id)
        ->where('estado', 'invalidado_cliente')
        ->count();

if ($invalidacionesVendedor >= 5) {
    return back()->with(
        'error',
        'Este vendedor tiene múltiples vouchers invalidados. Requiere revisión administrativa.'
    );
}
        $voucher = Voucher::create([
            'codigo' => strtoupper(Str::random(10)),
            'qr_token' => (string) Str::uuid(),

            'cliente_nombre' => $request->cliente_nombre,
            'cliente_rut' => $rutCifrado,
            'cliente_rut_hash' => $rutHash,

            'mascota_id' => $request->mascota_id,
            'servicio_id' => $servicio->id,
            'tipo_servicio' => $servicio->nombre,

            'valor' => $valor,
            'copago_usuario' => $copagoFinal,
            'saldo_cliente_aplicado' => $saldoAplicado,
            'comision_veterchile' => $comision,
            'saldo_veterinario' => $saldoVeterinario,

            'estado' => 'pendiente_cliente',
            'fecha_vencimiento' => now()->addDays(30),

            'vendedor_id' => auth()->user()->vendedor_id,
        ]);
        $montoPendienteAplicar = $saldoAplicado;

if ($montoPendienteAplicar > 0) {

    $saldos = ClienteSaldo::where('cliente_rut_hash', $rutHash)
        ->where('estado', 'disponible')
        ->orderBy('id', 'asc')
        ->get();

    foreach ($saldos as $saldo) {

        if ($montoPendienteAplicar <= 0) {
            break;
        }

        if ($saldo->monto <= $montoPendienteAplicar) {

            $saldo->update([
                'estado' => 'consumido',
                'voucher_consumido_id' => $voucher->id,
                'consumido_en' => now(),
            ]);

            $montoPendienteAplicar -= $saldo->monto;

        } else {

            $montoConsumido = $montoPendienteAplicar;
            $montoRestante = $saldo->monto - $montoConsumido;

            $saldo->update([
                'monto' => $montoConsumido,
                'estado' => 'consumido',
                'voucher_consumido_id' => $voucher->id,
                'consumido_en' => now(),
            ]);

            ClienteSaldo::create([
                'cliente_nombre' => $voucher->cliente_nombre,
                'cliente_rut_hash' => $rutHash,
                'monto' => $montoRestante,
                'origen' => 'saldo_restante',
                'estado' => 'disponible',
                'descripcion' => 'Saldo restante luego de aplicar crédito a voucher',
            ]);

            $montoPendienteAplicar = 0;
        }
    }

    VoucherAuditoria::create([
        'voucher_id' => $voucher->id,
        'accion' => 'saldo_cliente_aplicado',
        'usuario_tipo' => 'vendedor',
        'usuario_id' => auth()->id(),
        'descripcion' => 'Saldo cliente aplicado al copago por $' . $saldoAplicado,
        'ip' => request()->ip(),
    ]);
}
        $voucher->qr_firma = hash_hmac(
            'sha256',
            $voucher->id . $voucher->codigo,
            config('app.key')
        );

        $voucher->qr_expira = now()->addDays(30);

        $otp = random_int(100000, 999999);

        $voucher->otp_hash = hash('sha256', $otp);
        $voucher->otp_expira = now()->addMinutes(10);

        $voucher->save();

        VoucherAuditoria::create([
            'voucher_id' => $voucher->id,
            'accion' => 'voucher_emitido',
            'usuario_tipo' => 'vendedor',
            'usuario_id' => $voucher->vendedor_id,
            'descripcion' => 'Voucher emitido desde escritorio vendedor y enviado a aceptación del cliente',
            'ip' => request()->ip(),
        ]);

        $telefono = preg_replace('/[^0-9]/', '', $request->cliente_telefono);

        if (substr($telefono, 0, 2) !== '56') {
            $telefono = '56' . ltrim($telefono, '0');
        }

       $mensaje =
            "VETERCHILE\n\n".
            "Tu código para activar el voucher {$voucher->codigo} es: {$otp}\n".
            "Vence en 10 minutos.\n\n".
            "Si NO reconoces este voucher, invalídalo aquí:\n".
            route('vouchers.invalidar', $voucher->qr_token);

        $whatsappUrl = "https://wa.me/{$telefono}?text=" . urlencode($mensaje);

        return redirect()
            ->route('vouchers.show', $voucher->id)
            ->with('whatsapp_otp_url', $whatsappUrl)
            ->with('ok', 'Voucher creado correctamente.');
            $mensaje =
            "Voucher VETERCHILE\n\n".
            "Si NO reconoce este voucher puede invalidarlo aquí:\n\n".
            route('vouchers.invalidar',
                $voucher->qr_token);
                }

    public function show($id)
    {
        if (!auth()->check()) {
            abort(403);
        }

        $voucher = Voucher::findOrFail($id);

        if (auth()->user()->rol == 'vendedor'
            && $voucher->vendedor_id != auth()->user()->vendedor_id) {
            abort(403);
        }

        if (auth()->user()->rol == 'profesional'
            && $voucher->profesional_id != auth()->user()->profesional_id) {
            abort(403);
        }

        if (!in_array(auth()->user()->rol, ['admin', 'vendedor', 'profesional'])) {
            abort(403);
        }

        return view('vouchers.show', compact('voucher'));
    }

    public function marcarPagado($id)
    {
        $voucher = Voucher::findOrFail($id);

        $voucher->update([
            'estado' => 'activo',
        ]);

        if ($voucher->pagos()->count()) {
            $voucher->pagos()->latest()->first()->update([
                'estado_pago' => 'pagado',
                'metodo_pago' => 'manual',
            ]);
        }

        return redirect()
            ->route('vouchers.show', $voucher->id);
    }

    public function pagar($id)
    {
        $voucher = Voucher::findOrFail($id);

        if (auth()->user()->rol == 'vendedor'
            && $voucher->vendedor_id != auth()->user()->vendedor_id) {
            abort(403);
        }

        return view('vouchers.pagar', compact('voucher'));
    }

    public function procesarPago(Request $request, $id)
    {
        $voucher = Voucher::findOrFail($id);

        if (auth()->user()->rol == 'vendedor'
            && $voucher->vendedor_id != auth()->user()->vendedor_id) {
            abort(403);
        }

        $pago = $voucher->pagos()->latest()->first();

        if (!$pago) {
            \App\Models\VoucherPago::create([
                'voucher_id' => $voucher->id,
                'monto_pagado_usuario' => $voucher->copago_usuario,
                'metodo_pago' => $request->metodo_pago,
                'estado_pago' => 'pagado',
                'comprobante' => $request->comprobante,
            ]);
        } else {
            $pago->update([
                'monto_pagado_usuario' => $voucher->copago_usuario,
                'metodo_pago' => $request->metodo_pago,
                'estado_pago' => 'pagado',
                'comprobante' => $request->comprobante,
            ]);
        }

        $voucher->update([
            'estado' => 'activo',
        ]);
        if ($voucher->estado == 'invalidado_cliente') {
    return back()->with('error', 'Este voucher fue invalidado por el cliente.');
}
        VoucherAuditoria::create([
            'voucher_id' => $voucher->id,
            'accion' => 'pago_registrado',
            'usuario_tipo' => 'vendedor',
            'usuario_id' => $voucher->vendedor_id,
            'descripcion' => 'Pago registrado y voucher activado',
            'ip' => request()->ip(),
        ]);

        return redirect()
            ->route('vouchers.show', $voucher->id)
            ->with('ok', 'Pago registrado y voucher activado.');
    }

    // public function cobrar($id)
    // {
    //     $voucher = Voucher::findOrFail($id);
    //     if ($voucher->estado !== 'validado_atencion') {
    //     \App\Helpers\SecurityLogger::log(
    //     'intento_cobro_web_sin_validacion_clinica',
    //     'Voucher',
    //     $voucher->id,
    //     'rechazado',
    //     'Intento de cobro web sin atención validada',
    //     $voucher->cliente_id
    //      );

    //      return back()->with('error', 'Voucher no validado clínicamente');
    //     }

    //     if ($voucher->estado != 'activo') {
    //         return back()->with('error', 'El voucher no está activo.');
    //     }

    //     if (!$voucher->otp_validado_at) {
    //         VoucherAuditoria::create([
    //             'voucher_id' => $voucher->id,
    //             'accion' => 'cobro_rechazado_sin_otp',
    //             'usuario_tipo' => auth()->check() ? auth()->user()->rol : 'api',
    //             'usuario_id' => auth()->id(),
    //             'descripcion' => 'Intento de cobro sin validación OTP',
    //             'ip' => request()->ip(),
    //         ]);

    //         return back()->with('error', 'El cliente aún no ha validado el OTP.');
    //     }

    //     if ($voucher->qr_usado) {
    //         return back()->with('error', 'Este voucher ya fue usado.');
    //     }

    //     $voucher->update([
    //         'estado' => 'cobrado',
    //         'qr_usado' => true,
    //         'qr_usado_at' => now(),
    //         'usado_en' => now(),


    //     ]);
    //         if ($voucher->estado == 'invalidado_cliente') {
    //         return back()->with('error', 'Este voucher fue invalidado por el cliente.');
    //             }
    //             if ($voucher->estado !== 'validado_atencion') {
    //             \App\Helpers\SecurityLogger::log(
    //             'intento_cobro_web_sin_validacion_clinica',
    //             'Voucher',
    //             $voucher->id,
    //             'rechazado',
    //             'Intento de cobro web sin atención validada',
    //             $voucher->cliente_id
    //         );

    //         return back()->with('error', 'Voucher no validado clínicamente');
    //             }
    //             \App\Models\VoucherCobro::create([
    //                 'voucher_id' => $voucher->id,
    //                 'veterinario_nombre' => 'Veterinaria Demo',
    //                 'sucursal' => 'Sucursal Centro',
    //                 'monto_cobrado' => $voucher->saldo_veterinario,
    //                 'estado' => 'pendiente_rendicion',
    //                 'cobrado_en' => now(),
    //             ]);

    //             VoucherAuditoria::create([
    //                 'voucher_id' => $voucher->id,
    //                 'accion' => 'voucher_cobrado',
    //                 'usuario_tipo' => auth()->user()->rol,
    //                 'usuario_id' => auth()->id(),
    //                 'descripcion' => 'Voucher cobrado correctamente',
    //                 'ip' => request()->ip(),
    //             ]);

    //             return redirect()
    //                 ->route('vouchers.show', $voucher->id)
    //                 ->with('ok', 'Voucher cobrado correctamente.');
    // }
    public function cobrar($id)
{
    $voucher = Voucher::findOrFail($id);

    if ($voucher->estado == 'invalidado_cliente') {
        return back()->with('error', 'Este voucher fue invalidado por el cliente.');
    }

    if ($voucher->estado !== 'validado_atencion') {
        \App\Helpers\SecurityLogger::log(
            'intento_cobro_web_sin_validacion_clinica',
            'Voucher',
            $voucher->id,
            'rechazado',
            'Intento de cobro web sin atención validada',
            $voucher->cliente_id
        );

        return back()->with('error', 'Voucher no validado clínicamente.');
    }

    if ($voucher->qr_usado) {
        return back()->with('error', 'Este voucher ya fue usado.');
    }

    $voucher->update([
        'estado' => 'cobrado',
        'qr_usado' => true,
        'qr_usado_at' => now(),
        'usado_en' => now(),
    ]);

    \App\Models\VoucherCobro::create([
        'voucher_id' => $voucher->id,
        'profesional_id' => $voucher->profesional_id,
        'veterinario_nombre' => $voucher->prestador_nombre ?? 'Veterinaria Demo',
        'sucursal' => 'Sucursal Centro',
        'monto_cobrado' => $voucher->saldo_veterinario,
        'estado' => 'pendiente_rendicion',
        'cobrado_en' => now(),
    ]);

    VoucherAuditoria::create([
        'voucher_id' => $voucher->id,
        'accion' => 'voucher_cobrado_con_validacion_clinica',
        'usuario_tipo' => auth()->check() ? auth()->user()->rol : 'sistema',
        'usuario_id' => auth()->id(),
        'descripcion' => 'Voucher cobrado después de atención validada por asistente',
        'ip' => request()->ip(),
    ]);

    return redirect()
        ->route('vouchers.show', $voucher->id)
        ->with('ok', 'Voucher cobrado correctamente.');
}
    public function qr($token)
    {
        $voucher = Voucher::where('qr_token', $token)->firstOrFail();

        return view('vouchers.qr', compact('voucher'));
    }

    public function usar($token)
    {
        $voucher = Voucher::where('qr_token', $token)->firstOrFail();

        $profesionales = VoucherProfesional::where('activo', 1)
            ->orderBy('nombre')
            ->get();
if ($voucher->estado == 'invalidado_cliente') {
    return back()->with('error', 'Este voucher fue invalidado por el cliente.');
}
        return view('vouchers.usar', compact('voucher', 'profesionales'));
    }

    public function asignarProfesional(Request $request, $token)
    {
        $voucher = Voucher::where('qr_token', $token)->firstOrFail();

        if ($voucher->profesional_id) {
            return back()->with('error', 'Este voucher ya fue asignado.');
        }

        $voucher->update([
            'profesional_id' => $request->profesional_id,
            'estado' => 'asignado',
        ]);

        VoucherAuditoria::create([
            'voucher_id' => $voucher->id,
            'accion' => 'profesional_asignado',
            'usuario_tipo' => 'cliente',
            'usuario_id' => null,
            'descripcion' => 'Voucher asignado digitalmente al profesional ID ' . $request->profesional_id,
            'ip' => request()->ip(),
        ]);

        return redirect()
            ->route('vouchers.qr', $voucher->qr_token)
            ->with('ok', 'Voucher asignado correctamente.');
    }

    public function aceptarAtencion($id)
    {
        $voucher = Voucher::findOrFail($id);

        if (auth()->user()->rol != 'profesional'
            || $voucher->profesional_id != auth()->user()->profesional_id) {
            abort(403);
        }

        if ($voucher->estado != 'asignado') {
            return back();
        }

        $voucher->update([
            'estado' => 'en_atencion',
        ]);

        return back()->with('ok', 'Atención aceptada.');
    }
       public function finalizarAtencion($id)
{
    $voucher = Voucher::findOrFail($id);

    if (auth()->user()->rol != 'profesional'
        || $voucher->profesional_id != auth()->user()->profesional_id) {
        abort(403);
    }

    if (!in_array($voucher->estado, [
        'activo',
        'asignado',
        'en_atencion',
        'en atención',
    ])) {
        return back()->with('error', 'El voucher no está disponible para finalizar atención.');
    }

    $atencion = \App\Models\VoucherAtencion::updateOrCreate(
        ['voucher_id' => $voucher->id],
        [
            'agenda_id' => $voucher->agenda_id,
            'cliente_id' => $voucher->cliente_id,
            'mascota_id' => $voucher->mascota_id,
            'profesional_id' => auth()->user()->profesional_id,
            'inicio_atencion' => now(),
            'fin_atencion' => now(),
            'cerrada_at' => now(),
            'ip_profesional' => request()->ip(),
            'user_agent_profesional' => request()->userAgent(),
            'estado' => 'cerrada_por_profesional',
            'riesgo' => 'bajo',
            'observacion' => 'Atención finalizada desde panel profesional',
        ]
    );

    $voucher->update([
        'atencion_id' => $atencion->id,
        'profesional_atendio_id' => auth()->user()->profesional_id,
        'atencion_cerrada_at' => now(),
        'ip_profesional' => request()->ip(),
        'estado_validacion' => 'cerrada_por_profesional',
        'riesgo_validacion' => 'bajo',
        'estado' => 'atencion_cerrada',
    ]);

    \App\Models\VoucherAuditoria::create([
        'voucher_id' => $voucher->id,
        'accion' => 'atencion_cerrada_profesional',
        'usuario_tipo' => 'profesional',
        'usuario_id' => auth()->id(),
        'descripcion' => 'Atención cerrada por profesional. Pendiente validación asistente.',
        'ip' => request()->ip(),
    ]);

    return back()->with('ok', 'Atención finalizada. Pendiente validación por asistente.');
}
    // public function finalizarAtencion($id)
    // {
    //     $voucher = Voucher::findOrFail($id);

    //     if (auth()->user()->rol != 'profesional'
    //         || $voucher->profesional_id != auth()->user()->profesional_id) {
    //         abort(403);
    //     }

    //     if (!in_array($voucher->estado, [
    //         'activo',
    //         'asignado',
    //         'en_atencion',
    //         'en atención',
    //     ])) {
    //         return back()->with('error', 'El voucher no está disponible para finalizar.');
    //     }

    //     if (!$voucher->otp_validado_at) {
    //         VoucherAuditoria::create([
    //             'voucher_id' => $voucher->id,
    //             'accion' => 'cobro_rechazado_sin_otp',
    //             'usuario_tipo' => auth()->check() ? auth()->user()->rol : 'api',
    //             'usuario_id' => auth()->id(),
    //             'descripcion' => 'Intento de cobro sin validación OTP',
    //             'ip' => request()->ip(),
    //         ]);

    //         return back()->with('error', 'El cliente aún no ha validado el OTP.');
    //     }

    //     if ($voucher->qr_usado) {
    //         return back()->with('error', 'Este voucher ya fue usado.');
    //     }

    //     $voucher->update([
    //         'estado' => 'cobrado',
    //         'qr_usado' => true,
    //         'qr_usado_at' => now(),
    //         'usado_en' => now(),
    //     ]);

    //     $profesionalId = auth()->user()->profesional_id;

    //     \App\Models\VoucherCobro::create([
    //         'voucher_id' => $voucher->id,
    //         'profesional_id' => $profesionalId,
    //         'veterinario_nombre' => auth()->user()->name,
    //         'sucursal' => 'Sucursal principal',
    //         'monto_cobrado' => $voucher->saldo_veterinario,
    //         'estado' => 'pendiente_rendicion',
    //         'cobrado_en' => now(),
    //     ]);

    //     VoucherAuditoria::create([
    //         'voucher_id' => $voucher->id,
    //         'accion' => 'atencion_finalizada',
    //         'usuario_tipo' => 'profesional',
    //         'usuario_id' => $voucher->profesional_id,
    //         'descripcion' => 'Atención finalizada y voucher enviado a cobro/rendición',
    //         'ip' => request()->ip(),
    //     ]);

    //     return back()->with('ok', 'Atención cerrada y cobro generado.');
    // }

    public function aceptarVoucher(Request $request, $token)
    {
        $voucher = Voucher::where('qr_token', $token)->firstOrFail();

        if ($voucher->estado != 'pendiente_cliente') {
            return back();
        }

        $nuevoEstado = $voucher->copago_usuario > 0
            ? 'pendiente_pago'
            : 'activo';
if ($voucher->estado == 'invalidado_cliente') {
    return back()->with('error', 'Este voucher fue invalidado por el cliente.');
}
        $voucher->update([
            'estado' => $nuevoEstado,
            'cliente_aceptado_en' => now(),
        ]);

        VoucherAuditoria::create([
            'voucher_id' => $voucher->id,
            'accion' => 'cliente_acepto',
            'usuario_tipo' => 'cliente',
            'usuario_id' => null,
            'descripcion' => 'Cliente aceptó voucher',
            'ip' => request()->ip(),
        ]);

        return redirect()
            ->route('vouchers.qr', $voucher->qr_token)
            ->with('ok', 'Voucher aceptado.');
    }

    public function rechazarVoucher(Request $request, $token)
    {
        $voucher = Voucher::where('qr_token', $token)->firstOrFail();

        if ($voucher->estado != 'pendiente_cliente') {
            return back();
        }

        $voucher->update([
            'estado' => 'rechazado',
            'cliente_rechazado_en' => now(),
            'motivo_rechazo_cliente' => $request->motivo_rechazo,
        ]);

        VoucherAuditoria::create([
            'voucher_id' => $voucher->id,
            'accion' => 'cliente_rechazo',
            'usuario_tipo' => 'cliente',
            'usuario_id' => null,
            'descripcion' => 'Cliente rechazó voucher',
            'ip' => request()->ip(),
        ]);

        return redirect()
            ->route('vouchers.qr', $voucher->qr_token)
            ->with('ok', 'Voucher rechazado.');
    }

    public function validarOtp(Request $request, $qr_token)
    {
        $request->validate([
            'otp' => 'required|digits:6',
        ]);

        $voucher = Voucher::where('qr_token', $qr_token)->first();

        if (!$voucher) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'Voucher no encontrado',
            ], 404);
        }

        if ($voucher->otp_validado_at) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'OTP ya fue validado',
            ], 400);
        }

        if (!$voucher->otp_expira || now()->gt($voucher->otp_expira)) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'OTP expirado',
            ], 400);
        }

        $otpHash = hash('sha256', $request->otp);

        if ($otpHash !== $voucher->otp_hash) {
            return response()->json([
                'ok' => false,
                'mensaje' => 'OTP incorrecto',
            ], 400);
        }
if ($voucher->estado == 'invalidado_cliente') {
    return back()->with('error', 'Este voucher fue invalidado por el cliente.');
}
        $voucher->update([
            'otp_validado_at' => now(),
            'estado' => 'activo',
        ]);

        VoucherAuditoria::create([
            'voucher_id' => $voucher->id,
            'accion' => 'otp_validado_cliente',
            'usuario_tipo' => 'cliente',
            'usuario_id' => null,
            'descripcion' => 'Cliente validó OTP y activó voucher',
            'ip' => request()->ip(),
        ]);

        return response()->json([
            'ok' => true,
            'mensaje' => 'Voucher activado correctamente',
            'estado' => $voucher->estado,
        ]);
    $intentos = cache()->get(
    'validar_otp_'.$voucher->id.'_'.request()->ip(),
    0
);

if ($intentos >= 10) {

    $alerta = VoucherAlerta::create([
        'voucher_id' => $voucher->id,
        'tipo_alerta' => 'exceso_intentos_otp',
        'nivel' => 'rojo',
        'descripcion' => 'Demasiados intentos de validación OTP',
    ]);

    $this->notificarAuditor(
        $voucher,
        $alerta,
        'Exceso de intentos OTP',
        'Se detectaron múltiples intentos de validación OTP para el voucher '.$voucher->codigo
    );

    abort(429, 'Demasiados intentos.');
}

cache()->put(
    'validar_otp_'.$voucher->id.'_'.request()->ip(),
    $intentos + 1,
    now()->addMinutes(30)
);


    }
    public function reenviarOtp($token)
{
    $voucher = Voucher::where('qr_token', $token)->firstOrFail();

    if ($voucher->estado == 'cobrado' || $voucher->qr_usado) {
        return back()->with('error', 'No se puede reenviar OTP de un voucher ya cobrado.');
    }

    $otp = random_int(100000, 999999);

    $voucher->update([
        'otp_hash' => hash('sha256', $otp),
        'otp_expira' => now()->addMinutes(10),
        'otp_validado_at' => null,
    ]);

    VoucherAuditoria::create([
        'voucher_id' => $voucher->id,
        'accion' => 'otp_reenviado',
        'usuario_tipo' => auth()->check() ? auth()->user()->rol : 'cliente',
        'usuario_id' => auth()->id(),
        'descripcion' => 'OTP reenviado por WhatsApp',
        'ip' => request()->ip(),
    ]);

    $telefono = preg_replace('/[^0-9]/', '', $voucher->cliente_telefono);

    if (substr($telefono, 0, 2) !== '56') {
        $telefono = '56' . ltrim($telefono, '0');
    }

   $mensaje =
"VETERCHILE\n\n".
"Tu código para activar el voucher {$voucher->codigo} es: {$otp}\n".
"Vence en 10 minutos.\n\n".
"Si NO reconoces este voucher, invalídalo aquí:\n".
route('vouchers.invalidar', $voucher->qr_token);

    $whatsappUrl = "https://wa.me/{$telefono}?text=" . urlencode($mensaje);

    return redirect()
        ->route('vouchers.show', $voucher->id)
        ->with('whatsapp_otp_url', $whatsappUrl)
        ->with('ok', 'Nuevo OTP generado. Envíalo al cliente por WhatsApp.');

   $intentos = cache()->get(
    'otp_'.$voucher->id.'_'.request()->ip(),
    0
);

if ($intentos >= 5) {
    abort(429, 'Demasiados intentos. Espere 15 minutos.');
}

cache()->put(
    'otp_'.$voucher->id.'_'.request()->ip(),
    $intentos + 1,
    now()->addMinutes(15)
);
}

    public function invalidarCliente($token)
{
    $voucher = Voucher::where(
        'qr_token',
        $token
    )->firstOrFail();

    if (
        $voucher->estado == 'cobrado' ||
        $voucher->copago_devuelto
    ) {

        return back()->with(
            'error',
            'Voucher ya procesado.'
        );
    }

    $voucher->update([

        'estado' => 'invalidado_cliente',

        'qr_usado' => true,

        'qr_usado_at' => now(),

        'invalidado_en' => now(),

        'motivo_invalidacion' =>
            'Invalidado por cliente desde WhatsApp',

        'copago_devuelto' => true,
    ]);

    ClienteSaldo::create([

        'voucher_id' => $voucher->id,

        'cliente_nombre' =>
            $voucher->cliente_nombre,

        'cliente_rut_hash' =>
            $voucher->cliente_rut_hash,

        'monto' =>
            $voucher->copago_usuario,

        'origen' =>
            'voucher_invalidado',

        'estado' =>
            'disponible',

        'descripcion' =>
            'Saldo generado por invalidación de voucher',

    ]);
if ($voucher->copago_usuario >= 20000) {

    $alerta = \App\Models\VoucherAlerta::create([
    'voucher_id' => $voucher->id,
    'tipo_alerta' => 'invalidacion_copago_alto',
    'nivel' => 'rojo',
    'descripcion' => 'Cliente invalidó voucher con copago alto. Revisar posible fraude o error de emisión.',
]);

$this->notificarAuditor(
    $voucher,
    $alerta,
    'Invalidación con copago alto',
    'El voucher '.$voucher->codigo.' fue invalidado con copago de $'.number_format($voucher->copago_usuario, 0, ',', '.')
);

}
$invalidacionesCliente = Voucher::where('cliente_rut_hash', $voucher->cliente_rut_hash)
    ->where('estado', 'invalidado_cliente')
    ->count();

if ($invalidacionesCliente >= 3) {

  $alerta = \App\Models\VoucherAlerta::create([
    'voucher_id' => $voucher->id,
    'tipo_alerta' => 'invalidacion_copago_alto',
    'nivel' => 'rojo',
    'descripcion' => 'Cliente invalidó voucher con copago alto. Revisar posible fraude o error de emisión.',
]);

$this->notificarAuditor(
    $voucher,
    $alerta,
    'Invalidación con copago alto',
    'El voucher '.$voucher->codigo.' fue invalidado con copago de $'.number_format($voucher->copago_usuario, 0, ',', '.')
);
    if ($voucher->profesional_id) {

    $invalidacionesProfesional = Voucher::where('profesional_id', $voucher->profesional_id)
        ->where('estado', 'invalidado_cliente')
        ->count();

    if ($invalidacionesProfesional >= 5) {

       $alerta = \App\Models\VoucherAlerta::create([
    'voucher_id' => $voucher->id,
    'tipo_alerta' => 'invalidacion_copago_alto',
    'nivel' => 'rojo',
    'descripcion' => 'Cliente invalidó voucher con copago alto. Revisar posible fraude o error de emisión.',
]);

$this->notificarAuditor(
    $voucher,
    $alerta,
    'Invalidación con copago alto',
    'El voucher '.$voucher->codigo.' fue invalidado con copago de $'.number_format($voucher->copago_usuario, 0, ',', '.')
);

    }
}
    $invalidacionesVendedor = Voucher::where('vendedor_id', $voucher->vendedor_id)
    ->where('estado', 'invalidado_cliente')
    ->count();

if ($invalidacionesVendedor >= 5) {

   $alerta = \App\Models\VoucherAlerta::create([
    'voucher_id' => $voucher->id,
    'tipo_alerta' => 'invalidacion_copago_alto',
    'nivel' => 'rojo',
    'descripcion' => 'Cliente invalidó voucher con copago alto. Revisar posible fraude o error de emisión.',
]);

$this->notificarAuditor(
    $voucher,
    $alerta,
    'Invalidación con copago alto',
    'El voucher '.$voucher->codigo.' fue invalidado con copago de $'.number_format($voucher->copago_usuario, 0, ',', '.')
);

}

}

    VoucherAuditoria::create([

        'voucher_id' => $voucher->id,

        'accion' => 'voucher_invalidado_cliente',

        'usuario_tipo' => 'cliente',

        'descripcion' =>
            'Cliente invalidó voucher desde enlace WhatsApp',

        'ip' => request()->ip(),
    ]);

    return view(
        'vouchers.invalidado',
        compact('voucher')
    );
    if ($voucher->estado == 'cobrado' || $voucher->qr_usado || $voucher->copago_devuelto) {
    return view('vouchers.invalidado', compact('voucher'));
}
if ($voucher->copago_usuario > 0) {

    ClienteSaldo::create([
        'voucher_id' => $voucher->id,
        'cliente_nombre' => $voucher->cliente_nombre,
        'cliente_rut_hash' => $voucher->cliente_rut_hash,
        'monto' => $voucher->copago_usuario,
        'origen' => 'voucher_invalidado',
        'estado' => 'disponible',
        'descripcion' => 'Saldo generado por invalidación de voucher',
    ]);

}

}
private function notificarAuditor($voucher, $alerta, $titulo, $mensaje)
{
    \App\Models\AuditorNotificacion::create([
        'voucher_id' => $voucher->id,
        'alerta_id' => $alerta->id,
        'titulo' => $titulo,
        'mensaje' => $mensaje,
    ]);

    VoucherAuditoria::create([
        'voucher_id' => $voucher->id,
        'accion' => 'notificacion_auditor_creada',
        'usuario_tipo' => 'sistema',
        'usuario_id' => null,
        'descripcion' => $titulo,
        'ip' => request()->ip(),
    ]);
}

public function validarAtencionWeb($id)
{
    $voucher = Voucher::findOrFail($id);

    $atencion = \App\Models\VoucherAtencion::where('voucher_id', $voucher->id)->first();

    if (!$atencion || $atencion->estado !== 'cerrada_por_profesional') {
        return back()->with('error', 'La atención no está cerrada por profesional.');
    }

    if ($atencion->asistente_id || $atencion->estado === 'validada_por_asistente') {
        return back()->with('error', 'La atención ya fue validada.');
    }

    $asistenteId = auth()->id();

    $riesgo = 'bajo';

    if ((int) $atencion->profesional_id === (int) $asistenteId) {
        $riesgo = 'alto';
    }

    if ($atencion->ip_profesional && $atencion->ip_profesional === request()->ip()) {
        $riesgo = $riesgo === 'alto' ? 'alto' : 'medio';
    }

    $hashAuditoria = hash('sha256', implode('|', [
        $voucher->id,
        $atencion->id,
        $atencion->profesional_id,
        $asistenteId,
        $atencion->cerrada_at,
        now(),
        $atencion->ip_profesional,
        request()->ip(),
    ]));

    $atencion->update([
        'asistente_id' => $asistenteId,
        'validada_at' => now(),
        'ip_asistente' => request()->ip(),
        'user_agent_asistente' => request()->userAgent(),
        'estado' => 'validada_por_asistente',
        'riesgo' => $riesgo,
        'hash_auditoria' => $hashAuditoria,
    ]);

    $voucher->update([
        'agenda_id' => $atencion->agenda_id,
        'atencion_id' => $atencion->id,
        'profesional_atendio_id' => $atencion->profesional_id,
        'asistente_valido_id' => $asistenteId,
        'atencion_cerrada_at' => $atencion->cerrada_at,
        'validado_at' => now(),
        'ip_profesional' => $atencion->ip_profesional,
        'ip_asistente' => request()->ip(),
        'estado_validacion' => 'validada_por_asistente',
        'riesgo_validacion' => $riesgo,
        'estado' => 'validado_atencion',
    ]);

    \App\Models\VoucherCobro::firstOrCreate(
        ['voucher_id' => $voucher->id],
        [
            'profesional_id' => $voucher->profesional_id,
            'veterinario_nombre' => $voucher->prestador_nombre ?? 'Profesional',
            'sucursal' => 'Sucursal principal',
            'monto_cobrado' => $voucher->saldo_veterinario,
            'estado' => 'pendiente_rendicion',
            'cobrado_en' => now(),
        ]
    );

    return back()->with('ok', 'Atención validada por asistente. Riesgo: '.$riesgo);
}

public function confirmarInvalidacion($token)
{
    $voucher = Voucher::where('qr_token', $token)->firstOrFail();

    return view('vouchers.confirmar_invalidacion', compact('voucher'));
}
}
