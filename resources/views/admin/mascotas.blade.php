@extends('layouts.admin')
<head>
    <meta charset="UTF-8">
    <title>Cobros Profesional</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
@section('content')

<div class="container mt-4">
    <h3>🐾 Mascotas</h3>

    <div class="alert alert-warning">
        Módulo de mascotas pendiente de vincular a dueños.
    </div>

    <p>Total registros: {{ $mascotas->count() }}</p>

    <a href="/escritorio-admin" class="btn btn-secondary">
        Volver
    </a>
</div>

@endsection



{{--  @extends('layouts.app')

@section('content')

<div class="container">

    <h3>🐾 Mascotas</h3>


<table class="table table-bordered table-striped mt-3">
    <thead>
        <tr>
            <th>Mascota</th>
            <th>Especie</th>
            <th>Raza</th>
            <th>Dueño</th>
            <th>RUT Dueño</th>
            <th>Teléfono</th>
            <th>Email</th>
            <th>Activo</th>
        </tr>
    </thead>

    <tbody>
        @foreach($mascotas as $mascota)
            <tr>
                <td>{{ $mascota->nombre }}</td>
                <td>{{ $mascota->especie }}</td>
                <td>{{ $mascota->raza }}</td>
                <td>{{ $mascota->dueno_nombre }}</td>
                <td>{{ $mascota->dueno_rut }}</td>
                <td>{{ $mascota->dueno_telefono }}</td>
                <td>{{ $mascota->dueno_email }}</td>
                <td>{{ $mascota->activo ? 'Sí' : 'No' }}</td>
            </tr>
        @endforeach
    </tbody>
</table>
    <a href="/escritorio-admin" class="btn btn-secondary">
        Volver
    </a>

</div>

@endsection  --}}
   {{--  <table class="table table-bordered table-striped mt-3">
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Especie</th>
                <th>Raza</th>
                <th>Dueño</th>
                <th>Teléfono</th>
                <th>Activo</th>
            </tr>
        </thead>

        <tbody>
            @foreach($mascotas as $mascota)
                <tr>
                    <td>{{ $mascota->nombre }}</td>
                    <td>{{ $mascota->especie }}</td>
                    <td>{{ $mascota->raza }}</td>
                    <td>{{ $mascota->dueno_nombre }}</td>
                    <td>{{ $mascota->dueno_telefono }}</td>
                    <td>{{ $mascota->activo ? 'Sí' : 'No' }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>  --}}
