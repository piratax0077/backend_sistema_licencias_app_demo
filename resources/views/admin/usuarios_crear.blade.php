<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">

    <title>Crear Usuario</title>

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

    <a href="/admin/usuarios"
       class="btn btn-secondary mb-4">
        Volver
    </a>

    <div class="row justify-content-center">

        <div class="col-md-7">

            <div class="card border-0 shadow-sm p-5">

                <h2 class="fw-bold mb-4">
                    👤 Crear Usuario
                </h2>

                <form method="POST"
                      action="{{ route('admin.usuarios.store') }}">

                    @csrf

                    <div class="mb-3">
                        <label>Nombre</label>

                        <input type="text"
                               name="name"
                               class="form-control"
                               required>
                    </div>
                    <div class="mb-3">
                        <label>RUT</label>

                        <input type="text"
                            name="rut"
                            class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label>Teléfono</label>

                        <input type="text"
                            name="telefono"
                            class="form-control">
                    </div>

                    <div class="mb-3">
                        <label>Email</label>

                        <input type="email"
                               name="email"
                               class="form-control"
                               required>
                    </div>

                    <div class="mb-3">
                        <label>Contraseña</label>

                        <input type="password"
                               name="password"
                               class="form-control"
                               required>
                    </div>

                    <div class="mb-3">
                        <label>Rol</label>

                        <select name="rol"
                                class="form-select"
                                required>

                            <option value="vendedor">
                                Vendedor
                            </option>

                            <option value="profesional">
                                Profesional
                            </option>

                            <option value="auditor">
                                Auditor
                            </option>

                            <option value="admin">
                                Administrador
                            </option>
                            <option value="cliente">
                                Cliente / Dueño Mascota
                            </option>

                        </select>
                    </div>

                    <div class="mb-3">
                        <label>ID vendedor (opcional)</label>
                        <select name="vendedor_id"
                                class="form-select">

                            <option value="">  Sin vendedor  </option>

                                @foreach($vendedores as $vendedor)

                                    <option value="{{ $vendedor->id }}">
                                        {{ $vendedor->nombre }}
                                    </option>

                                @endforeach

                            </select>



                    </div>

                    <div class="mb-3">
                        <label>ID profesional (opcional)</label>

                        <select name="profesional_id"
                                class="form-select">

                            <option value="">
                                Sin profesional
                            </option>

                            @foreach($profesionales as $profesional)

                                <option value="{{ $profesional->id }}">
                                    {{ $profesional->nombre }}
                                </option>

                            @endforeach

                        </select>
                    </div>

                    <div class="form-check mb-4">

                        <input type="checkbox"
                               name="activo"
                               value="1"
                               checked
                               class="form-check-input"
                               id="activo">

                        <label class="form-check-label"
                               for="activo">
                            Usuario activo
                        </label>

                    </div>

                    <button class="btn btn-primary w-100">
                        Crear Usuario
                    </button>

                </form>

            </div>

        </div>

    </div>

</div>

</body>
</html>
