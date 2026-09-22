<!doctype html>
<html lang="es"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>@yield('title', 'Demo de licencias · SDI')</title><link rel="stylesheet" href="{{ asset('demo-assets/demo.css') }}"></head>
<body>
<header class="top"><a class="brand" href="{{ route('demo.index') }}"><span class="brandmark">SDI</span><span>Salud Digital Integrada<small>Licencias médicas</small></span></a><span class="demo-badge">DEMO FUNCIONAL · DATOS FICTICIOS</span><span class="stack">Laravel 13 · PHP 8.4</span></header>
<nav class="roles" aria-label="Perfiles de demostración"><a class="button small" href="/">Inicio · Atención</a><span class="roles-label">Cambiar perfil</span>@foreach(\App\Services\DemoLicenciaService::ROLES as $key=>$name)<form method="POST" action="{{ route('demo.role') }}">@csrf<input type="hidden" name="role" value="{{ $key }}"><button class="{{ ($role ?? 'admin') === $key ? 'active' : '' }}">{{ $name }}</button></form>@endforeach<a class="button small" href="{{ route('fiscalizacion.index') }}">Fiscalización de reposo ↗</a></nav>
<main class="wrap">
@if(session('ok'))<div class="notice success" role="status">{{ session('ok') }}</div>@endif
@if($errors->any())<div class="notice error" role="alert"><strong>No se pudo completar la acción.</strong>@foreach($errors->all() as $error)<div>{{ $error }}</div>@endforeach</div>@endif
@yield('content')
<footer>Demostración basada en el flujo proporcionado. Operadores, organismos, biometría y transferencias se simulan. Los perfiles permiten presentar el recorrido; no equivalen a autenticación productiva.</footer>
</main><script>document.querySelectorAll('form').forEach(f=>f.addEventListener('submit',()=>{if(f.checkValidity()){f.querySelectorAll('button[type="submit"],button:not([type])').forEach(b=>{b.disabled=true;b.classList.add('busy')})}}));</script>@yield('scripts')</body></html>
