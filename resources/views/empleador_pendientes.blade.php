<!doctype html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Empleador - licencias pendientes</title>
    <style>
        body { background:#ecf0f5; color:#263238; font-family:Arial,sans-serif; margin:0; padding:18px; }
        .wrap { max-width:1100px; margin:0 auto; }
        .head { border-left:4px solid #0b9eb7; margin-bottom:14px; padding-left:12px; }
        h1 { color:#0b7c94; font-size:22px; margin:0; }
        .card { background:#fff; border:1px solid #d8e4ec; border-radius:6px; box-shadow:0 2px 6px rgba(38,50,56,.08); margin-bottom:14px; overflow:hidden; }
        h2 { background:linear-gradient(90deg,#0b8fa6,#12a9bf); color:#fff; font-size:14px; margin:0; padding:9px 12px; text-transform:uppercase; }
        .body { padding:12px; }
        input { border:1px solid #cfd8dc; border-radius:3px; min-height:34px; padding:7px 8px; width:260px; }
        button, .btn { background:#e5f7fb; border:1px solid #8ed5df; border-radius:4px; color:#08798f; cursor:pointer; font-weight:700; padding:8px 12px; text-decoration:none; }
        table { border-collapse:collapse; margin-top:10px; width:100%; }
        th { background:#eef6f8; color:#37474f; text-align:left; }
        th, td { border:1px solid #cfd8dc; padding:7px 8px; vertical-align:top; }
        .muted { color:#607d8b; font-size:12px; }
    </style>
</head>
<body>
<div class="wrap">
    <div class="head">
        <h1>Consulta de empleador</h1>
        <p class="muted">Solo aparecen licencias despues de autorizacion del paciente.</p>
    </div>

    <div class="card">
        <h2>Buscar pendientes</h2>
        <div class="body">
            <form method="GET" action="{{ route('empleador.licencias') }}">
                <input name="rut" value="{{ $rut }}" placeholder="RUT empleador">
                <button type="submit">Consultar</button>
                <a class="btn" href="{{ route('licencia.index') }}">Volver</a>
            </form>
        </div>
    </div>

    <div class="card">
        <h2>Licencias y documentos requeridos</h2>
        <div class="body">
            <table>
                <thead>
                    <tr>
                        <th>Folio</th>
                        <th>Paciente</th>
                        <th>Estado empleador</th>
                        <th>Documentos</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($pendientes as $empleador)
                        <tr>
                            <td>{{ $empleador->expediente->folio }}</td>
                            <td>{{ optional($empleador->expediente->paciente)->nombre }}<br><span class="muted">{{ optional($empleador->expediente->paciente)->rut }}</span></td>
                            <td>{{ $empleador->estado }}</td>
                            <td>
                                @foreach($empleador->documentosRequeridos as $doc)
                                    <strong>{{ $doc->nombre }}</strong><br>
                                    <span class="muted">{{ $doc->descripcion }}</span><br><br>
                                @endforeach
                            </td>
                        </tr>
                    @empty
                        <tr><td colspan="4">No hay pendientes para este RUT o aun falta autorizacion del paciente.</td></tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
