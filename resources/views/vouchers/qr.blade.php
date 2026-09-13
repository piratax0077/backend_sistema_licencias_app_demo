<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">

    <title>QR Voucher</title>

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

    <div class="row justify-content-center">

        <div class="col-md-7">

            <div class="card shadow border-0">

                <div class="card-body p-5 text-center">

                    <h2 class="mb-4">
                        🎟️ Voucher VETERCHILE
                    </h2>

                    <div class="mb-4">

                        {!! QrCode::size(300)->generate(
                            url('/api/vouchers/'.$voucher->qr_token.'/validar')
                        ) !!}

                    </div>

                    <hr>

                    <h4>
                        {{ $voucher->cliente_nombre }}
                    </h4>

                    <p>
                        <strong>RUT:</strong>
                        {{ $voucher->cliente_rut_visible }}
                    </p>

                    <p>
                        <strong>Servicio:</strong>
                        {{ $voucher->tipo_servicio }}
                    </p>

                    <p>
                        <strong>Estado:</strong>
                        {{ $voucher->estado }}
                    </p>

                    <hr>

                    <div class="row">

                        <div class="col-md-4">
                            <small>Valor</small>

                            <h5>
                                ${{ number_format($voucher->valor, 0, ',', '.') }}
                            </h5>
                        </div>

                        <div class="col-md-4">
                            <small>Copago</small>

                            <h5>
                                ${{ number_format($voucher->copago_usuario, 0, ',', '.') }}
                            </h5>
                        </div>

                        <div class="col-md-4">
                            <small>Veterinaria</small>

                            <h5>
                                ${{ number_format($voucher->saldo_veterinario, 0, ',', '.') }}
                            </h5>
                        </div>

                    </div>

                    <hr>

                    <p class="text-muted">
                        Código:
                        {{ $voucher->codigo }}
                    </p>

                    <a href="{{ route('vouchers.show', $voucher->id) }}"
                       class="btn btn-dark mt-3">
                        Volver
                    </a>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>
