<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Auditoría</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body style="background:#f4f7fb;">

<div class="container py-5">
    <div class="d-flex justify-content-end mb-4">

        <form method="POST"
            action="{{ route('logout') }}">
            @csrf

            <button class="btn btn-danger">
                Cerrar sesión
            </button>
        </form>

    </div>

    <a href="/escritorio-admin"
       class="btn btn-secondary mb-4">
        Volver
    </a>

    <h2 class="fw-bold mb-4">
        🛡️ Auditoría VETERCHILE Vouchers
    </h2>

    <div class="card p-4 border-0 shadow-sm">
        <a href="{{ route('auditoria.notificaciones') }}"
            class="btn btn-danger">
            Ver Notificaciones Auditor
        </a>
        <a href="{{ route('auditoria.logins') }}"
            class="btn btn-dark">
                Auditoría Login
        </a>
        <table class="table table-hover align-middle">

            <thead>
                <tr>
                    <th>ID</th>
                    <th>Voucher</th>
                    <th>Acción</th>
                    <th>Usuario Tipo</th>
                    <th>Usuario ID</th>
                    <th>Descripción</th>
                    <th>IP</th>
                    <th>Fecha</th>
                </tr>
            </thead>

            <tbody>

                @forelse($auditorias as $a)

                    <tr>
                        <td>{{ $a->id }}</td>
                        <td>{{ $a->voucher->codigo ?? '-' }}</td>
                        <td>{{ $a->accion }}</td>
                        <td>{{ $a->usuario_tipo }}</td>
                        <td>{{ $a->usuario_id }}</td>
                        <td>{{ $a->descripcion }}</td>
                        <td>{{ $a->ip }}</td>
                        <td>{{ $a->created_at }}</td>
                    </tr>

                @empty

                    <tr>
                        <td colspan="8">
                            No hay registros de auditoría.
                        </td>
                    </tr>

                @endforelse

            </tbody>

        </table>

    </div>


</div>

</body>
</html>
