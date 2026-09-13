<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Emitir Voucher</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body style="background:#f4f7fb;">

@php
    $servicios = \App\Models\VoucherServicio::where('activo', 1)
        ->orderBy('nombre')
        ->get();

       $mascotas = \App\Models\VoucherMascota::where('activo', 1)
        ->orderBy('nombre')
        ->get();
@endphp


<div class="container py-5">

    <div class="d-flex justify-content-between mb-4">

        <a href="/escritorio-vendedor"
           class="btn btn-secondary">
            Volver
        </a>

        <form method="POST"
              action="{{ route('logout') }}">
            @csrf

            <button class="btn btn-danger">
                Cerrar sesión
            </button>
        </form>

    </div>

    <div class="row justify-content-center">

        <div class="col-md-8">

            <div class="card shadow border-0">

                <div class="card-body p-5">

                    <h2 class="mb-4">
                        🎟️ Emitir Voucher
                    </h2>

                    <form method="POST"
                          action="{{ route('vouchers.store') }}">

                        @csrf

                        <div class="mb-3">
                            <label>Cliente</label>

                            <input type="text"
                                   name="cliente_nombre"
                                   class="form-control"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label>RUT Cliente</label>

                            <input type="text"
                                   name="cliente_rut"
                                   class="form-control"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label>Mascota</label>

                            <select name="mascota_id"
                                    id="mascota_id"
                                    class="form-select"
                                    required>

                                <option value="">
                                    Seleccione Mascota
                                </option>

                                @foreach($mascotas as $mascota)

                                    <option
                                        value="{{ $mascota->id }}"
                                        data-dueno="{{ $mascota->dueno_nombre }}"
                                        data-rut="{{ $mascota->dueno_rut }}">

                                        {{ $mascota->nombre }} — {{ $mascota->dueno_nombre }}

                                    </option>

                                @endforeach

                            </select>
                        </div>
                        <div class="mb-3">
                            <label>Servicio</label>

                            <select name="servicio_id"
                                    id="servicio_id"
                                    class="form-select"
                                    required>

                                <option value="">
                                    Seleccione Servicio
                                </option>

                                @foreach($servicios as $servicio)

                                    <option
                                        value="{{ $servicio->id }}"
                                        data-valor="{{ $servicio->valor_base }}"
                                        data-copago="{{ $servicio->copago_base }}"
                                        data-comision="{{ $servicio->comision_veterchile }}">

                                        {{ $servicio->nombre }}

                                    </option>

                                @endforeach

                            </select>
                        </div>

                        <div class="mb-3">
                            <label>Valor Total</label>

                            <input id="valor"
                                   name="valor"
                                   class="form-control"
                                   readonly>
                        </div>

                        <div class="mb-3">
                            <label>Copago Usuario</label>

                            <input id="copago_usuario"
                                   name="copago_usuario"
                                   class="form-control"
                                   readonly>
                        </div>

                        <div class="mb-3">
                            <label>Comisión VETERCHILE</label>

                            <input id="comision_veterchile"
                                   name="comision_veterchile"
                                   class="form-control"
                                   readonly>
                        </div>

                        <button class="btn btn-primary btn-lg w-100">
                            Emitir Voucher
                        </button>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

<script>
document
    .getElementById('servicio_id')
    .addEventListener('change', function () {

        let opcion = this.options[this.selectedIndex];

        document.getElementById('valor').value =
            opcion.dataset.valor || 0;

        document.getElementById('copago_usuario').value =
            opcion.dataset.copago || 0;

        document.getElementById('comision_veterchile').value =
            opcion.dataset.comision || 0;
    });
    document
    .getElementById('mascota_id')
    .addEventListener('change', function () {

        let opcion = this.options[this.selectedIndex];

        document.querySelector('[name="cliente_nombre"]').value =
            opcion.dataset.dueno || '';

        document.querySelector('[name="cliente_rut"]').value =
            opcion.dataset.rut || '';
    });
</script>

</body>
</html>
