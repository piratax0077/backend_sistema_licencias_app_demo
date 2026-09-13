<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Escritorio Profesional</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
        <a href="{{ route('profesional.cobros') }}"
        class="btn btn-success mb-4">
            Ver Cobros Pendientes
        </a>

    </div>

    <a href="/" class="btn btn-secondary mb-4">
        Volver
    </a>

    <h2 class="fw-bold mb-4">
        🏥 Escritorio Profesional VETERCHILE
    </h2>

    <div class="card p-4 border-0 shadow-sm">

        <h5 class="fw-bold mb-3">
            Vouchers asignados
        </h5>

        <table class="table table-hover align-middle">

            <thead>
                <tr>
                    <th>Código</th>
                    <th>Cliente</th>
                    <th>RUT Dueño</th>
                    <th>Servicio</th>
                    <th>Monto a cobrar</th>
                    <th>Estado</th>
                    <th>Acción</th>
                </tr>
            </thead>

            <tbody>

                @forelse($vouchers as $voucher)

                    <tr>
                        <td>{{ $voucher->codigo }}</td>
                        <td>{{ $voucher->cliente_nombre }}</td>
                        <td>{{ $voucher->cliente_rut_visible }}</td>
                        <td>{{ $voucher->tipo_servicio }}</td>
                        <td>${{ number_format($voucher->saldo_veterinario, 0, ',', '.') }}</td>
                        <td>{{ $voucher->estado }}</td>
                        <td>
                            <a href="{{ route('vouchers.show', $voucher->id) }}"
                            class="btn btn-sm btn-primary mb-1">
                                Ver
                            </a>

                            @if(in_array(trim($voucher->estado), ['activo', 'asignado', 'en_atencion', 'en_ atención', 'en atención']))

                                <form method="POST"
                                    action="{{ route('profesional.vouchers.finalizar', $voucher->id) }}">
                                    @csrf

                                    <button class="btn btn-sm btn-success">
                                        Finalizar Atención
                                    </button>
                                </form>

                            @elseif($voucher->estado == 'usado')

                                <span class="badge bg-success">
                                    Atención cerrada
                                </span>

                            @else

                                <span class="text-muted">
                                    Sin acción
                                </span>

                            @endif
                        </td>
                    </tr>

                @empty

                    <tr>
                        <td colspan="7">
                            No hay vouchers asignados a este profesional.
                        </td>
                    </tr>

                @endforelse

            </tbody>

        </table>

    </div>

</div>

</body>
</html>
