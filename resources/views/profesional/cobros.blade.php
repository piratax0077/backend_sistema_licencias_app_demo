<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Cobros Profesional</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body style="background:#f4f7fb;">

<div class="container py-5">

    <a href="/escritorio-profesional"
       class="btn btn-secondary mb-4">
        Volver
    </a>

    <h2 class="fw-bold mb-4">
        💳 Escritorio de Cobros
    </h2>
    @if(session('ok'))
    <div class="alert alert-success">
        {{ session('ok') }}
    </div>
    @endif

    @if(session('error'))
        <div class="alert alert-danger">
            {{ session('error') }}
        </div>
    @endif

    <form method="POST"
        action="{{ route('profesional.cobros.generarRendicion') }}"
        class="mb-4">
        @csrf

        <button class="btn btn-primary">
            Generar Rendición
        </button>
    </form>
    <div class="row g-4 mb-4">

        <div class="col-md-6">
            <div class="card p-4 border-0 shadow-sm">
                <h6>Cantidad de vouchers</h6>
                <h2>{{ $cobros->count() }}</h2>
            </div>
        </div>

        <div class="col-md-6">
            <div class="card p-4 border-0 shadow-sm">
                <h6>Total a rendir</h6>
                <h2>${{ number_format($cobros->sum('monto_cobrado'), 0, ',', '.') }}</h2>
            </div>
        </div>

    </div>

    <div class="card p-4 border-0 shadow-sm">

        <h5 class="fw-bold mb-3">
            Vouchers pendientes de rendición
        </h5>

        <table class="table table-hover align-middle">
            <thead>
                <tr>
                    <th>ID Cobro</th>
                    <th>Voucher</th>
                    <th>Monto</th>
                    <th>Estado</th>
                    <th>Fecha Cobro</th>
                </tr>
            </thead>

            <tbody>
                @forelse($cobros as $cobro)
                    <tr>
                        <td>{{ $cobro->id }}</td>
                        <td>{{ $cobro->voucher->codigo ?? '-' }}</td>
                        <td>${{ number_format($cobro->monto_cobrado, 0, ',', '.') }}</td>
                        <td>{{ $cobro->estado }}</td>
                        <td>{{ $cobro->cobrado_en }}</td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="5">
                            No hay cobros pendientes de rendición.
                        </td>
                    </tr>
                @endforelse
            </tbody>
        </table>

    </div>

</div>

</body>
</html>
