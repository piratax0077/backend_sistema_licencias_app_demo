<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Licencias SDI</title>
    <style>
        body { background:#ecf0f5; color:#263238; font-family:Arial,sans-serif; margin:0; }
        .wrap { max-width:1280px; margin:0 auto; padding:18px; }
        .head { border-left:4px solid #0b9eb7; margin-bottom:16px; padding-left:12px; }
        h1 { color:#0b7c94; font-size:24px; margin:0; }
        p { color:#607d8b; margin:4px 0 0; }
        .grid { display:grid; gap:12px; grid-template-columns:repeat(12,1fr); }
        .s2{grid-column:span 2}.s3{grid-column:span 3}.s4{grid-column:span 4}.s5{grid-column:span 5}.s6{grid-column:span 6}.s8{grid-column:span 8}.s12{grid-column:span 12}
        .card { background:#fff; border:1px solid #d8e4ec; border-radius:6px; box-shadow:0 2px 6px rgba(38,50,56,.08); margin-bottom:14px; overflow:hidden; }
        .card h2 { background:linear-gradient(90deg,#0b8fa6,#12a9bf); color:#fff; font-size:14px; margin:0; padding:9px 12px; text-transform:uppercase; }
        .body { padding:12px; }
        label { color:#455a64; display:block; font-size:11px; font-weight:700; margin-bottom:4px; text-transform:uppercase; }
        input, select, textarea { border:1px solid #cfd8dc; border-radius:3px; font-size:13px; min-height:33px; padding:7px 8px; width:100%; }
        textarea { min-height:90px; resize:vertical; }
        button, .btn { background:#e5f7fb; border:1px solid #8ed5df; border-radius:4px; color:#08798f; cursor:pointer; display:inline-block; font-weight:700; padding:8px 12px; text-decoration:none; }
        .btn-light { background:#fff; border-color:#b0bec5; color:#455a64; }
        .alert { border-radius:4px; margin-bottom:12px; padding:10px 12px; }
        .ok { background:#e8f5e9; border:1px solid #a5d6a7; color:#2e7d32; }
        .token { background:#fff8e1; border:1px solid #ffe082; color:#7a5b00; }
        table { border-collapse:collapse; width:100%; }
        th { background:#eef6f8; color:#37474f; text-align:left; }
        th, td { border:1px solid #cfd8dc; padding:7px 8px; vertical-align:top; }
        .muted { color:#607d8b; font-size:12px; }
        @media(max-width:850px){.grid{display:block}.grid>div{margin-bottom:10px}}
    </style>
</head>
<body>
<main class="wrap">
    <div class="head">
        <h1>Licencias Medicas SDI</h1>
        <p>Emision desde licencia.blade.php conectada a API, app Licencias Reposo, autorizacion paciente y notificacion a empleadores.</p>
    </div>

    @if(session('ok'))
        <div class="alert ok">{{ session('ok') }}</div>
    @endif

    @if(session('token_autorizacion'))
        <div class="alert token">
            Token app Licencias Reposo: <strong>{{ session('token_autorizacion') }}</strong><br>
            URL web de autorizacion: <a href="{{ route('licencia.autorizar', session('token_autorizacion')) }}">{{ route('licencia.autorizar', session('token_autorizacion')) }}</a>
        </div>
    @endif

    <form method="POST" action="{{ route('licencia.store') }}">
        @csrf
        <div class="card">
            <h2>Datos de licencia</h2>
            <div class="body grid">
                <div class="s3"><label>Folio</label><input name="folio" placeholder="automatico si queda vacio"></div>
                <div class="s3"><label>Tipo licencia</label><select name="tipo_licencia"><option>Enfermedad comun</option><option>Maternal</option><option>Laboral</option><option>SANNA</option></select></div>
                <div class="s2"><label>Dias reposo</label><input type="number" name="dias_reposo" value="7"></div>
                <div class="s2"><label>Inicio reposo</label><input type="date" name="fecha_inicio_reposo"></div>
                <div class="s2"><label>Fin reposo</label><input type="date" name="fecha_fin_reposo"></div>
                <div class="s3"><label>Codigo diagnostico</label><input name="diagnostico_codigo"></div>
                <div class="s9"><label>Descripcion diagnostico</label><input name="diagnostico_descripcion"></div>
            </div>
        </div>

        <div class="card">
            <h2>Paciente / trabajador</h2>
            <div class="body grid">
                <div class="s3"><label>RUT paciente</label><input name="paciente_rut" data-rut-lookup="paciente" placeholder="Sin puntos ni guion" required></div>
                <div class="s5"><label>Nombre paciente</label><input name="paciente_nombre" required></div>
                <div class="s4"><label>Email paciente</label><input type="email" name="paciente_email"></div>
                <div class="s3"><label>Telefono</label><input name="paciente_telefono"></div>
                <div class="s5"><label>Direccion</label><input name="paciente_direccion"></div>
                <div class="s4"><label>Prevision</label><input name="paciente_prevision" placeholder="Fonasa / Isapre"></div>
            </div>
        </div>

        <div class="card">
            <h2>Profesional que emite</h2>
            <div class="body grid">
                <div class="s3"><label>RUT profesional</label><input name="profesional_rut" placeholder="Sin puntos ni guion"></div>
                <div class="s5"><label>Nombre profesional</label><input name="profesional_nombre" required></div>
                <div class="s4"><label>Especialidad</label><input name="profesional_especialidad"></div>
                <div class="s6"><label>Email profesional</label><input type="email" name="profesional_email"></div>
                <div class="s6"><label>Firma/hash</label><input name="profesional_firma_hash"></div>
            </div>
        </div>

        <div class="card">
            <h2>Empleador(es) a notificar despues de autorizacion del paciente</h2>
            <div class="body">
                @for($i = 0; $i < 3; $i++)
                    <div class="grid" style="border-bottom:1px solid #e3edf2; margin-bottom:10px; padding-bottom:10px">
                        <div class="s3"><label>RUT empleador {{ $i + 1 }}</label><input name="empleadores[{{ $i }}][rut]" data-rut-lookup="empleador" placeholder="Sin puntos ni guion"></div>
                        <div class="s4"><label>Razon social</label><input name="empleadores[{{ $i }}][razon_social]" {{ $i === 0 ? 'required' : '' }}></div>
                        <div class="s3"><label>Email</label><input type="email" name="empleadores[{{ $i }}][email]"></div>
                        <div class="s2"><label>Telefono</label><input name="empleadores[{{ $i }}][telefono]"></div>
                        <div class="s6"><label>Direccion</label><input name="empleadores[{{ $i }}][direccion]"></div>
                        <div class="s3"><label>Afiliado CCAF</label><select name="empleadores[{{ $i }}][afiliado_ccaf]"><option value="0">No</option><option value="1">Si</option></select></div>
                        <div class="s3"><label>Nombre CCAF</label><input name="empleadores[{{ $i }}][ccaf_nombre]"></div>
                    </div>
                @endfor
                <p class="muted">Regla: la licencia queda bloqueada para empleador hasta que el paciente autorice desde app Licencias Reposo o URL de autorizacion.</p>
            </div>
        </div>

        <button type="submit">Crear licencia y solicitar autorizacion al paciente</button>
        <a class="btn btn-light" href="{{ route('empleador.licencias') }}">Consultar como empleador</a>
    </form>

    <div class="card" style="margin-top:16px">
        <h2>Ultimas licencias</h2>
        <div class="body">
            <table>
                <thead>
                    <tr>
                        <th>Folio</th>
                        <th>Paciente</th>
                        <th>Estado</th>
                        <th>Autorizacion</th>
                        <th>Empleadores</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($expedientes as $expediente)
                        <tr>
                            <td>{{ $expediente->folio }}</td>
                            <td>{{ optional($expediente->paciente)->nombre }}<br><span class="muted">{{ optional($expediente->paciente)->rut }}</span></td>
                            <td>{{ $expediente->estado }}</td>
                            <td>
                                {{ optional($expediente->autorizacionPaciente)->estado }}
                                @if(optional($expediente->autorizacionPaciente)->token)
                                    <br><a href="{{ route('licencia.autorizar', $expediente->autorizacionPaciente->token) }}">ver</a>
                                @endif
                            </td>
                            <td>
                                @foreach($expediente->empleadores as $empleador)
                                    {{ $empleador->razon_social }} <span class="muted">({{ $empleador->estado }})</span><br>
                                @endforeach
                            </td>
                        </tr>
                    @empty
                        <tr><td colspan="5">Sin licencias creadas.</td></tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
</main>
<script>
    async function consultarRut(input) {
        const rut = input.value.replace(/[^0-9kK]/g, '');
        if (rut.length < 7) {
            return;
        }

        const response = await fetch(`/api/personas/rut/${rut}`, {
            headers: { Accept: 'application/json' }
        });

        if (!response.ok) {
            return;
        }

        const payload = await response.json();
        const data = payload.data || {};
        input.value = data.rut || input.value;

        if (input.dataset.rutLookup === 'paciente' && data.paciente) {
            document.querySelector('[name="paciente_nombre"]').value ||= data.paciente.nombre || '';
            document.querySelector('[name="paciente_email"]').value ||= data.paciente.email || '';
            document.querySelector('[name="paciente_telefono"]').value ||= data.paciente.telefono || '';
            document.querySelector('[name="paciente_direccion"]').value ||= data.paciente.direccion || '';
            document.querySelector('[name="paciente_prevision"]').value ||= data.paciente.prevision || '';
        }

        if (input.dataset.rutLookup === 'empleador' && data.empleador) {
            const row = input.closest('.grid');
            row.querySelector('[name$="[razon_social]"]').value ||= data.empleador.razon_social || '';
            row.querySelector('[name$="[email]"]').value ||= data.empleador.email || '';
            row.querySelector('[name$="[telefono]"]').value ||= data.empleador.telefono || '';
            row.querySelector('[name$="[direccion]"]').value ||= data.empleador.direccion || '';
        }
    }

    document.querySelectorAll('[data-rut-lookup]').forEach((input) => {
        input.addEventListener('blur', () => consultarRut(input));
    });
</script>
</body>
</html>
