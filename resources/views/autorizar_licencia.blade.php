<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Autorizar licencia</title>
    <style>
        body { background:#ecf0f5; color:#263238; font-family:Arial,sans-serif; margin:0; padding:24px; }
        .card { background:#fff; border:1px solid #d8e4ec; border-radius:6px; box-shadow:0 2px 6px rgba(38,50,56,.08); margin:0 auto; max-width:760px; overflow:hidden; }
        h1 { background:linear-gradient(90deg,#0b8fa6,#12a9bf); color:#fff; font-size:20px; margin:0; padding:12px 14px; }
        .body { padding:14px; }
        dl { display:grid; gap:8px 12px; grid-template-columns:180px 1fr; }
        dt { color:#455a64; font-weight:700; text-transform:uppercase; }
        dd { margin:0; }
        textarea { border:1px solid #cfd8dc; border-radius:3px; min-height:90px; padding:8px; width:100%; }
        button { border-radius:4px; cursor:pointer; font-weight:700; margin-right:8px; padding:9px 14px; }
        .ok { background:#e5f7fb; border:1px solid #8ed5df; color:#08798f; }
        .danger { background:#fff; border:1px solid #ef9a9a; color:#b71c1c; }
    </style>
</head>
<body>
<div class="card">
    <h1>Autorizacion del paciente</h1>
    <div class="body">
        <p>Antes de enviar esta licencia al empleador, el paciente debe autorizar el proceso.</p>
        <dl>
            <dt>Folio</dt><dd>{{ $autorizacion->expediente->folio }}</dd>
            <dt>Paciente</dt><dd>{{ optional($autorizacion->expediente->paciente)->nombre }} - {{ optional($autorizacion->expediente->paciente)->rut }}</dd>
            <dt>Profesional</dt><dd>{{ optional($autorizacion->expediente->profesional)->nombre }}</dd>
            <dt>Tipo licencia</dt><dd>{{ $autorizacion->expediente->tipo_licencia }}</dd>
            <dt>Reposo</dt><dd>{{ $autorizacion->expediente->dias_reposo }} dias</dd>
            <dt>Estado</dt><dd>{{ $autorizacion->estado }}</dd>
        </dl>

        <form method="POST" action="{{ route('licencia.autorizar.responder', $autorizacion->token) }}">
            @csrf
            <label>Observacion</label>
            <textarea name="observacion"></textarea>
            <div style="margin-top:12px">
                <button class="ok" name="aprueba" value="1">Autorizar envio al empleador</button>
                <button class="danger" name="aprueba" value="0">Rechazar</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
