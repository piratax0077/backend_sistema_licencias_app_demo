<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Mascotas</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">
</head>

<body style="background:#f4f7fb;">

<div class="container py-5">

    <div class="d-flex justify-content-between mb-4">

        <h2>
            🐾 Mis Mascotas
        </h2>

        <form method="POST"
              action="{{ route('logout') }}">
            @csrf

            <button class="btn btn-danger">
                Cerrar sesión
            </button>
        </form>

    </div>

    <div class="row">

        <div class="col-12">
            <p>Escritorio de cliente</p>
        </div>
    </div>
</div>

</body>
</html>
