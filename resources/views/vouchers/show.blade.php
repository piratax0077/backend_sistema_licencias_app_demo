<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Voucher</title>
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

    </div>

    <div class="card shadow border-0 p-5">

        <h2>🎟️ Voucher {{ $voucher->codigo }}</h2>

        <hr>

        <p><strong>Cliente:</strong> {{ $voucher->cliente_nombre }}</p>
        <p><strong>RUT:</strong> {{ $voucher->cliente_rut_visible }}</p>
        <p><strong>Servicio:</strong> {{ $voucher->tipo_servicio }}</p>
        <p><strong>Estado:</strong> {{ $voucher->estado }}</p>

        <hr>

        <p><strong>Valor:</strong> ${{ number_format($voucher->valor, 0, ',', '.') }}</p>
        <p><strong>Copago Usuario:</strong> ${{ number_format($voucher->copago_usuario, 0, ',', '.') }}</p>
        <p><strong>Comisión VETERCHILE:</strong> ${{ number_format($voucher->comision_veterchile, 0, ',', '.') }}</p>
        <p><strong>Saldo Veterinario:</strong> ${{ number_format($voucher->saldo_veterinario, 0, ',', '.') }}</p>

        <hr>

        <p><strong>QR Token:</strong></p>
        <code>{{ $voucher->qr_token }}</code>

        <div class="mt-4 d-flex gap-2 flex-wrap">

            @if($voucher->estado == 'pendiente_pago')
                <a href="{{ route('vouchers.pagar', $voucher->id) }}"
                class="btn btn-success">
                    Registrar Pago
                </a>
            @endif

            @if($voucher->estado == 'activo')
                <form method="POST"
                    action="{{ route('vouchers.cobrar', $voucher->id) }}">
                    @csrf

                    <button type="submit" class="btn btn-primary">
                        Cobrar Voucher
                    </button>
                </form>
            @endif

            <a href="{{ route('vouchers.qr', $voucher->qr_token) }}"
            class="btn btn-dark">
                Ver QR
            </a>

            @if(session('whatsapp_otp_url'))
                <a href="{{ session('whatsapp_otp_url') }}"
                target="_blank"
                class="btn btn-success">
                    Enviar OTP por WhatsApp
                </a>
            @endif
            @if($voucher->estado != 'cobrado' && !$voucher->qr_usado)
                <form method="POST"
                    action="{{ route('vouchers.reenviarOtp', $voucher->qr_token) }}">
                    @csrf

                    <button type="submit" class="btn btn-warning">
                        Reenviar OTP
                    </button>
                </form>
            @endif
            @if($voucher->estado == 'activo' || $voucher->estado == 'usado' || $voucher->estado == 'cobrado')
                <a href="https://wa.me/?text={{ urlencode('Hola, este es tu voucher VETERCHILE. Úsalo aquí: '.route('vouchers.usar', $voucher->qr_token)) }}"
                target="_blank"
                class="btn btn-success">
                    Enviar Voucher WhatsApp
                </a>
            @endif
            @if($voucher->saldo_cliente_aplicado > 0)
                <div class="alert alert-info mt-3">
                    Se aplicó saldo cliente por:
                    <strong>${{ number_format($voucher->saldo_cliente_aplicado, 0, ',', '.') }}</strong>
                </div>
            @endif
            <a href="{{ route('vouchers.index') }}"
            class="btn btn-secondary">
                Volver
            </a>

        </div>


    </div>

</div>

</body>
</html>
