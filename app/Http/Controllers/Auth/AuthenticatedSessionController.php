<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use App\Providers\RouteServiceProvider;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\LoginAuditoria;

class AuthenticatedSessionController extends Controller
{
    /**
     * Display the login view.
     *
     * @return \Illuminate\View\View
     */
    public function create()
    {
        return view('auth.login');
    }

    /**
     * Handle an incoming authentication request.
     *
     * @param  \App\Http\Requests\Auth\LoginRequest  $request
     * @return \Illuminate\Http\RedirectResponse
     */
public function store(LoginRequest $request)
{
    $request->authenticate();

    $request->session()->regenerate();
    if (auth()->user()->activo == 0) {

    LoginAuditoria::create([
        'user_id' => auth()->id(),
        'email' => auth()->user()->email,
        'resultado' => 'rechazado_usuario_inactivo',
        'ip' => $request->ip(),
        'user_agent' => $request->userAgent(),
    ]);

    Auth::guard('web')->logout();

    $request->session()->invalidate();
    $request->session()->regenerateToken();

    return redirect('/login')->withErrors([
        'email' => 'Usuario inactivo. Contacte al administrador.'
    ]);
    $user = auth()->user();

if (in_array($user->rol, ['admin', 'auditor'])) {

    $otp = random_int(100000, 999999);

    $user->update([
        'login_otp_hash' => hash('sha256', $otp),
        'login_otp_expira' => now()->addMinutes(10),
        'login_otp_validado_at' => null,
    ]);

    LoginAuditoria::create([
        'user_id' => $user->id,
        'email' => $user->email,
        'resultado' => 'otp_login_generado',
        'ip' => $request->ip(),
        'user_agent' => $request->userAgent(),
    ]);

    session([
        'login_otp_user_id' => $user->id,
        'login_otp_pending' => true,
    ]);

    Auth::guard('web')->logout();

    return redirect()
        ->route('login.otp.form')
        ->with('otp_demo', $otp);
}
}
    LoginAuditoria::create([
        'user_id' => auth()->id(),
        'email' => auth()->user()->email,
        'resultado' => 'exitoso',
        'ip' => $request->ip(),
        'user_agent' => $request->userAgent(),
    ]);

    return redirect()->intended(RouteServiceProvider::HOME);
}

    /**
     * Destroy an authenticated session.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\RedirectResponse
     */
   public function destroy(Request $request)
{
    $user = Auth::user();

    if ($user) {
        LoginAuditoria::create([
            'user_id' => $user->id,
            'email' => $user->email,
            'resultado' => 'logout',
            'ip' => $request->ip(),
            'user_agent' => $request->userAgent(),
        ]);
    }

    Auth::guard('web')->logout();

    $request->session()->invalidate();

    $request->session()->regenerateToken();

    return redirect('/');
}
public function validarLoginOtp(Request $request)
{
    $intentos = cache()->get(
    'login_otp_'.$userId.'_'.request()->ip(),
    0
    );

    if ($intentos >= 5) {

        AuditorNotificacion::create([
            'titulo' => 'Exceso intentos OTP Login',
            'mensaje' => 'Se detectaron múltiples intentos OTP para usuario '.$userId,
        ]);

        abort(429, 'Demasiados intentos.');
    }
    $request->validate([
        'otp' => 'required|string|max:6'
    ]);

    $userId = session('login_otp_user_id');

    if (!$userId) {
        return redirect('/login');
    }
if (
    env('IP_WHITELIST_ENABLED', false) &&
    in_array($user->rol, ['admin', 'auditor'])
) {

    $ipPermitida = \App\Models\IpAutorizada::where('activo', true)
        ->where('ip', $request->ip())
        ->where(function ($q) use ($user) {
            $q->where('user_id', $user->id)
              ->orWhere('rol', $user->rol);
        })
        ->exists();

    if (!$ipPermitida) {

        LoginAuditoria::create([
            'user_id' => $user->id,
            'email' => $user->email,
            'resultado' => 'ip_no_autorizada',
            'ip' => $request->ip(),
            'user_agent' => $request->userAgent(),
        ]);

        AuditorNotificacion::create([
            'titulo' => 'Intento desde IP no autorizada',
            'mensaje' => 'Usuario '.$user->email.' intentó ingresar desde IP '.$request->ip(),
        ]);

        return redirect('/login')->withErrors([
            'email' => 'IP no autorizada para este perfil.'
        ]);
    }
}



    $userId = session('login_otp_user_id');

if (!$userId) {
    return redirect('/login');
}

$intentos = cache()->get(
    'login_otp_'.$userId.'_'.request()->ip(),
    0
);

if ($intentos >= 5) {

    AuditorNotificacion::create([
        'voucher_id' => null,
        'alerta_id' => null,
        'titulo' => 'Exceso intentos OTP Login',
        'mensaje' => 'Se detectaron múltiples intentos OTP para usuario '.$userId,
    ]);

    abort(429, 'Demasiados intentos.');
}

$user = \App\Models\User::findOrFail($userId);

    if (in_array($user->rol, ['admin', 'auditor'])) {

    $ipPermitida = \App\Models\IpAutorizada::where('activo', true)
        ->where('ip', $request->ip())
        ->where(function ($q) use ($user) {
            $q->where('user_id', $user->id)
              ->orWhere('rol', $user->rol);
        })
        ->exists();

    if (!$ipPermitida) {

        LoginAuditoria::create([
            'user_id' => $user->id,
            'email' => $user->email,
            'resultado' => 'ip_no_autorizada',
            'ip' => $request->ip(),
            'user_agent' => $request->userAgent(),
        ]);

        AuditorNotificacion::create([
            'titulo' => 'Intento desde IP no autorizada',
            'mensaje' => 'Usuario '.$user->email.' intentó ingresar desde IP '.$request->ip(),
        ]);

        return redirect('/login')->withErrors([
            'email' => 'IP no autorizada para este perfil.'
        ]);
    }
}

    if (!$user->login_otp_expira ||
        now()->gt($user->login_otp_expira)) {

        return back()->withErrors([
            'otp' => 'OTP expirado.'
        ]);
    }

    if (
        hash('sha256', $request->otp)
        !==
        $user->login_otp_hash
    ) {

        LoginAuditoria::create([
            'user_id' => $user->id,
            'email' => $user->email,
            'resultado' => 'otp_login_fallido',
            'ip' => $request->ip(),
            'user_agent' => $request->userAgent(),
        ]);
        cache()->put(
    'login_otp_'.$userId.'_'.request()->ip(),
    $intentos + 1,
    now()->addMinutes(30)
);
        return back()->withErrors([
            'otp' => 'OTP incorrecto.'
        ]);
    }

    $user->update([
        'login_otp_validado_at' => now(),
    ]);

    Auth::login($user);
    cache()->forget(
    'login_otp_'.$userId.'_'.request()->ip()
);
    $user->update([
    'login_otp_hash' => null,
    'login_otp_expira' => null,
]);
    $request->session()->regenerate();

    session()->forget('login_otp_user_id');
    session()->forget('login_otp_pending');

    LoginAuditoria::create([
        'user_id' => $user->id,
        'email' => $user->email,
        'resultado' => 'otp_login_exitoso',
        'ip' => $request->ip(),
        'user_agent' => $request->userAgent(),
    ]);

    return redirect()->intended(
        \App\Providers\RouteServiceProvider::HOME
    );
}
}
