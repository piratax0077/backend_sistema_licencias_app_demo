<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

use App\Http\Controllers\VoucherWebController;
use App\Http\Controllers\RendicionController;

use App\Models\User;
use App\Models\Voucher;
use App\Models\VoucherCobro;
use App\Models\VoucherAuditoria;
use App\Models\VoucherLiquidacion;
use App\Models\VoucherProfesional;
use App\Models\VoucherRendicion;
use App\Models\VoucherVendedor;
use App\Models\VoucherServicio;
use App\Http\Controllers\AuditoriaController;
use App\Models\VoucherMascota;

/* PÚBLICAS */

Route::get('/', function () {
    return redirect('/login');
});

Route::post('/logout', function (Request $request) {
    Auth::logout();
    $request->session()->invalidate();
    $request->session()->regenerateToken();
    return redirect('/login');
})->name('logout');

Route::get('/voucher/{token}/usar', [VoucherWebController::class, 'usar'])->name('vouchers.usar');

Route::post('/voucher/{token}/asignar-profesional', [VoucherWebController::class, 'asignarProfesional'])->name('vouchers.asignarProfesional');

/* REDIRECCIÓN POR ROL */

Route::get('/redirigir-rol', function () {
    $user = auth()->user();

    if ($user->rol == 'admin') return redirect('/escritorio-admin');
    if ($user->rol == 'vendedor') return redirect('/escritorio-vendedor');
    if ($user->rol == 'profesional') return redirect('/escritorio-profesional');
    if ($user->rol == 'auditor') return redirect('/auditoria');
    if ($user->rol == 'cliente') {
    return redirect('/cliente/mascotas');
}

    abort(403);
})->middleware('auth');

/* ADMIN */

Route::middleware(['auth', 'rol:admin'])->group(function () {

    Route::get('/escritorio-admin', function () {
        return view('escritorios.admin');
    });
    Route::get('/admin/servicios', function () {

        $servicios = VoucherServicio::orderBy('id', 'desc')->get();

        return view('admin.servicios', compact('servicios'));

    })->name('admin.servicios');

    Route::get('/admin/servicios/crear', function () {

        return view('admin.servicios_crear');

    })->name('admin.servicios.crear');

    Route::post('/admin/servicios', function (Request $request) {

        VoucherServicio::create([
            'nombre' => $request->nombre,
            'descripcion' => $request->descripcion,
            'valor_base' => $request->valor_base ?? 0,
            'copago_base' => $request->copago_base ?? 0,
            'comision_veterchile' => $request->comision_veterchile ?? 0,
            'activo' => $request->activo ?? 1,
        ]);

        return redirect('/admin/servicios');

    })->name('admin.servicios.store');

    Route::get('/dashboard-financiero', function () {
        $totalEmitido = Voucher::sum('valor');
        $totalCopagos = Voucher::sum('copago_usuario');
        $totalComision = Voucher::sum('comision_veterchile');

        $pendienteRendicion = VoucherCobro::where('estado', 'pendiente_rendicion')->sum('monto_cobrado');
        $totalRendido = VoucherRendicion::sum('total_cobrado');

        $vouchers = Voucher::orderBy('id', 'desc')->take(10)->get();

        return view('admin.dashboard_financiero', compact(
            'totalEmitido',
            'totalCopagos',
            'totalComision',
            'pendienteRendicion',
            'totalRendido',
            'vouchers'
        ));
    });

    Route::get('/admin/usuarios', function () {
        $usuarios = User::orderBy('id', 'desc')->get();
        return view('admin.usuarios', compact('usuarios'));
    });

    Route::get('/admin/usuarios/crear', function () {
        $vendedores = VoucherVendedor::orderBy('nombre')->get();
        $profesionales = VoucherProfesional::orderBy('nombre')->get();

        return view('admin.usuarios_crear', compact('vendedores', 'profesionales'));
    });

    Route::post('/admin/usuarios', function (Request $request) {
        User::create([
            'name' => $request->name,
            'email' => $request->email,
            'rut' => $request->rut,
        'telefono' => $request->telefono,
            'password' => Hash::make($request->password),
            'rol' => $request->rol,
            'activo' => $request->activo ?? 1,
            'vendedor_id' => $request->vendedor_id,
            'profesional_id' => $request->profesional_id,
        ]);
        $user = User::create([
    'name' => $request->name,
    'email' => $request->email,
    'rut' => $request->rut,
    'telefono' => $request->telefono,
    'password' => Hash::make($request->password),
]);

        return redirect('/admin/usuarios');
    })->name('admin.usuarios.store');

    Route::get('/admin/usuarios/{id}/editar', function ($id) {
        $usuario = User::findOrFail($id);
        $vendedores = VoucherVendedor::orderBy('nombre')->get();
        $profesionales = VoucherProfesional::orderBy('nombre')->get();

        return view('admin.usuarios_editar', compact('usuario', 'vendedores', 'profesionales'));
    })->name('admin.usuarios.editar');

    Route::post('/admin/usuarios/{id}/actualizar', function (Request $request, $id) {
        $usuario = User::findOrFail($id);

        $data = [
            'name' => $request->name,
            'email' => $request->email,
            'rol' => $request->rol,
            'activo' => $request->activo ?? 0,
            'vendedor_id' => $request->vendedor_id,
            'profesional_id' => $request->profesional_id,
        ];

        if ($request->password) {
            $data['password'] = Hash::make($request->password);
        }

        $usuario->update($data);

        return redirect('/admin/usuarios');
    })->name('admin.usuarios.actualizar');

    Route::get('/admin/profesionales', function () {
        $profesionales = VoucherProfesional::orderBy('id', 'desc')->get();
        return view('admin.profesionales', compact('profesionales'));
    });

    Route::get('/admin/vendedores', function () {
        $vendedores = VoucherVendedor::orderBy('id', 'desc')->get();
        return view('admin.vendedores', compact('vendedores'));
    });

    Route::get('/rendiciones', [RendicionController::class, 'index'])->name('rendiciones.index');
    Route::post('/rendiciones/generar', [RendicionController::class, 'generar'])->name('rendiciones.generar');
    Route::post('/rendiciones/{id}/generar-liquidacion', [RendicionController::class, 'generarLiquidacion'])->name('rendiciones.generarLiquidacion');

    Route::get('/liquidaciones', function () {
        $liquidaciones = VoucherLiquidacion::orderBy('id', 'desc')->get();
        return view('liquidaciones.index', compact('liquidaciones'));
    });

    Route::post('/liquidaciones/{id}/pagar', [RendicionController::class, 'pagarLiquidacion'])->name('liquidaciones.pagar');
});
Route::get('/admin/vendedores/crear', function () {
    return view('admin.vendedores_crear');
})->name('admin.vendedores.crear');

Route::post('/admin/vendedores', function (Request $request) {

    VoucherVendedor::create([
        'nombre' => $request->nombre,
        'rut' => $request->rut,
        'email' => $request->email,
        'telefono' => $request->telefono,
        'activo' => $request->activo ?? 1,
    ]);

    return redirect('/admin/vendedores');

})->name('admin.vendedores.store');
Route::get('/admin/profesionales/crear', function () {
    return view('admin.profesionales_crear');
})->name('admin.profesionales.crear');

Route::post('/admin/profesionales', function (Request $request) {
$profesional = VoucherProfesional::create([
    'nombre' => $request->nombre,
    'rut' => $request->rut,
    'especialidad' => $request->especialidad,
    'telefono' => $request->telefono,
    'email' => $request->email,
    'activo' => $request->activo ?? 1,
    'banco' => $request->banco,
    'tipo_cuenta' => $request->tipo_cuenta,
    'numero_cuenta' => $request->numero_cuenta,
    'titular_cuenta' => $request->titular_cuenta,
    'rut_cuenta' => $request->rut_cuenta,
]);
User::create([
    'name' => $profesional->nombre,
    'email' => $profesional->email,
    'password' => Hash::make($request->password ?? 'password'),
    'rol' => 'profesional',
    'activo' => 1,
    'vendedor_id' => null,
    'profesional_id' => $profesional->id,
]);
    return redirect('/admin/profesionales');

})->name('admin.profesionales.store');

/* CLIENTE*/

Route::middleware(['auth','rol:cliente'])->group(function () {

    Route::get('/cliente/mascotas', function () {

        $rut = auth()->user()->rut;

        $mascotas = \App\Models\VoucherMascota
            ::where('dueno_rut', $rut)
            ->orderBy('nombre')
            ->get();

        return view(
            'cliente.mascotas',
            compact('mascotas')
        );

    })->name('cliente.mascotas');

});

Route::get('/cliente/mascotas/{id}/vouchers', function ($id) {

    $rut = auth()->user()->rut;

    $mascota = \App\Models\VoucherMascota::where('id', $id)
        ->where('dueno_rut', $rut)
        ->firstOrFail();

    $vouchers = \App\Models\Voucher::where('mascota_id', $mascota->id)
        ->orderBy('id', 'desc')
        ->get();

    return view('cliente.mascota_vouchers', compact(
        'mascota',
        'vouchers'
    ));

})->name('cliente.mascotas.vouchers');



/* VENDEDOR */

Route::middleware(['auth', 'rol:vendedor'])->group(function () {
    Route::get('/escritorio-vendedor', function () {
        return view('escritorios.vendedor');
    });

    Route::get('/vendedores/caja', function () {
        return view('vendedores.caja');
    });

    Route::get('/vouchers', [VoucherWebController::class, 'index'])->name('vouchers.index');
    Route::get('/vouchers/crear', [VoucherWebController::class, 'create'])->name('vouchers.create');
    Route::post('/vouchers', [VoucherWebController::class, 'store'])->name('vouchers.store');

    Route::get('/vouchers/{id}/pagar', [VoucherWebController::class, 'pagar'])->name('vouchers.pagar');
    Route::post('/vouchers/{id}/procesar-pago', [VoucherWebController::class, 'procesarPago'])->name('vouchers.procesarPago');
    Route::post('/vouchers/{id}/pagado', [VoucherWebController::class, 'marcarPagado'])->name('vouchers.pagado');
});
/* PROFESIONAL */

Route::middleware(['auth', 'rol:profesional'])->group(function () {

    Route::get('/escritorio-profesional', function () {

        $profesionalId = Auth::user()->profesional_id;

        $vouchers = Voucher::where('profesional_id', $profesionalId)
            ->orderBy('id', 'desc')
            ->get();

        return view('escritorios.profesional', compact('vouchers'));

    });

});


/* MASCOTAS*/
Route::get('/admin/mascotas', function () {

    $mascotas = VoucherMascota::orderBy('id', 'desc')->get();

    return view('admin.mascotas', compact('mascotas'));

})->name('admin.mascotas');

Route::get('/admin/mascotas/crear', function () {

    return view('admin.mascotas_crear');

})->name('admin.mascotas.crear');

Route::post('/admin/mascotas', function (Request $request) {

    VoucherMascota::create([
        'nombre' => $request->nombre,
        'especie' => $request->especie,
        'raza' => $request->raza,
        'sexo' => $request->sexo,
        'fecha_nacimiento' => $request->fecha_nacimiento,
        'color' => $request->color,
        'microchip' => $request->microchip,
        'dueno_rut' => $request->dueno_rut,
        'dueno_nombre' => $request->dueno_nombre,
        'dueno_telefono' => $request->dueno_telefono,
        'dueno_email' => $request->dueno_email,
        'activo' => $request->activo ?? 1,
    ]);

    return redirect('/admin/mascotas');

})->name('admin.mascotas.store');


/* PROFESIONAL */

Route::middleware(['auth', 'rol:profesional'])->group(function () {

        Route::post('/profesional/cobros/generar-rendicion', function () {

        $profesionalId = auth()->user()->profesional_id;

        $cobros = \App\Models\VoucherCobro::where('profesional_id', $profesionalId)
            ->where('estado', 'pendiente_rendicion')
            ->whereNull('voucher_rendicion_id')
            ->get();

        if ($cobros->count() == 0) {
            return back()->with('error', 'No hay cobros pendientes.');
        }

        $rendicion = \App\Models\VoucherRendicion::create([
            'veterinario_nombre' => optional(auth()->user())->name,
            'sucursal' => 'Sucursal principal',
            'total_cobrado' => $cobros->sum('monto_cobrado'),
            'cantidad_vouchers' => $cobros->count(),
            'estado' => 'pendiente',
            'rendida_en' => now(),
        ]);

        foreach ($cobros as $cobro) {
            $cobro->update([
                'voucher_rendicion_id' => $rendicion->id,
                'estado' => 'rendido',
            ]);
        }

        return back()->with('ok', 'Rendición enviada a administración.');

    })->name('profesional.cobros.generarRendicion');

    Route::get('/profesional/prueba-atencion', function () {

    $vouchers = \App\Models\Voucher::where('estado', 'activo')
        ->orderBy('id', 'desc')
        ->get();

    return view('profesional.prueba_atencion', compact('vouchers'));

    });
        /* PROFESIONAL PRUEBA ATENCION*/

   Route::get('/profesional/prueba-atencion', function () {

    $profesionalId = auth()->user()->profesional_id;

    $vouchers = \App\Models\Voucher::where('profesional_id', $profesionalId)
        ->whereIn('estado', ['activo', 'asignado', 'en_atencion'])
        ->orderBy('id', 'desc')
        ->get();

    return view('profesional.prueba_atencion', compact('vouchers'));

    });

    Route::post('/profesional/vouchers/{id}/aceptar',
        [VoucherWebController::class, 'aceptarAtencion'])
        ->name('profesional.vouchers.aceptar');

    Route::post('/profesional/vouchers/{id}/finalizar',
        [VoucherWebController::class, 'finalizarAtencion'])
        ->name('profesional.vouchers.finalizar');

    Route::post('/vouchers/{id}/cobrar',
        [VoucherWebController::class, 'cobrar'])
        ->name('vouchers.cobrar');

    Route::get('/profesional/cobros', function () {
        $profesionalId = auth()->user()->profesional_id;

        $cobros = \App\Models\VoucherCobro::where('profesional_id', $profesionalId)
            ->where('estado', 'pendiente_rendicion')
            ->orderBy('id', 'desc')
            ->get();

        return view('profesional.cobros', compact('cobros'));
    })->name('profesional.cobros');

});


/* VOUCHERS COMPARTIDOS */

Route::middleware(['auth', 'rol:admin,vendedor,profesional'])->group(function () {

    Route::get('/vouchers/{id}',
        [VoucherWebController::class, 'show'])
        ->name('vouchers.show');

    Route::get('/voucher/qr/{token}',
        [VoucherWebController::class, 'qr'])
        ->name('vouchers.qr');

});


/* CLIENTE - WHATSAPP / QR */

Route::post('/voucher/{token}/aceptar',
    [VoucherWebController::class, 'aceptarVoucher'])
    ->name('vouchers.aceptar');

Route::post('/voucher/{token}/rechazar',
    [VoucherWebController::class, 'rechazarVoucher'])
    ->name('vouchers.rechazar');


/* AUDITORÍA */

Route::middleware(['auth', 'rol:admin,auditor'])->group(function () {

    Route::get('/auditoria',
        [AuditoriaController::class, 'index']);

    Route::get('/admin/alertas',
        [AuditoriaController::class, 'alertas'])
        ->name('admin.alertas');

    Route::post('/admin/alertas/{id}/resolver',
        [AuditoriaController::class, 'resolver'])
        ->name('admin.alertas.resolver');

    Route::get('/escritorio-auditor', function () {
        return redirect('/auditoria');
    });

});
/* AUTH BREEZE */

require __DIR__.'/auth.php';
