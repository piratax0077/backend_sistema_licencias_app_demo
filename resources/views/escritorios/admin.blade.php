<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Admin Vouchers</title>
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

    <a href="/" class="btn btn-secondary mb-4">
        Volver
    </a>

    <h2 class="fw-bold mb-4">
        🛡️ Administrador VETERCHILE Vouchers
    </h2>

    <div class="row g-4">

    <div class="col-md-4">
        <div class="card p-4 shadow-sm border-0">
            <h5>Dashboard Financiero</h5>
            <p>Resumen financiero, comisiones, rendiciones y caja.</p>
            <a href="/dashboard-financiero" class="btn btn-info">
                Ver Dashboard
            </a>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card p-4 shadow-sm border-0">
            <h5>Usuarios</h5>
            <p>Crear usuarios, roles y permisos.</p>
            <a href="/admin/usuarios" class="btn btn-primary">
                Administrar Usuarios
            </a>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card p-4 shadow-sm border-0">
            <h5>💰 Saldos Clientes</h5>

            <p>
                Copagos retenidos como saldo a favor.
            </p>

            <a href="{{ route('admin.saldos.clientes') }}"
            class="btn btn-warning">
                Ver Saldos Clientes
            </a>
        </div>
    </div>
    <div class="col-md-4">

        <div class="card p-4 shadow-sm border-0">

            <h5>🐾 Mascotas</h5>

            <p>
                Registro y administración de mascotas.
            </p>

            <a href="/admin/mascotas"
            class="btn btn-primary">
                Ver Mascotas
            </a>

        </div>

    </div>

    <div class="col-md-4">
        <div class="card p-4 shadow-sm border-0">
            <h5>Profesionales</h5>
            <p>Veterinarios, laboratorios y centros autorizados.</p>
            <a href="/admin/profesionales" class="btn btn-dark">
                Ver Profesionales
            </a>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card p-4 shadow-sm border-0">
            <h5>Vendedores</h5>
            <p>Vendedores autorizados para emitir vouchers.</p>
            <a href="/admin/vendedores" class="btn btn-success">
                Ver Vendedores
            </a>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card p-4 shadow-sm border-0">
            <h5>Rendiciones</h5>
            <p>Cobros enviados a pago por profesionales.</p>
            <a href="/rendiciones" class="btn btn-warning">
                Ver Rendiciones
            </a>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card p-4 shadow-sm border-0">
            <h5>Liquidaciones</h5>
            <p>Pagos a profesionales y comisión VETERCHILE.</p>
            <a href="/liquidaciones" class="btn btn-success">
                Ver Liquidaciones
            </a>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card p-4 shadow-sm border-0">
            <h5>Auditoría</h5>
            <p>Trazabilidad, fraudes, anulaciones y control interno.</p>
            <a href="/auditoria" class="btn btn-danger">
                Auditoría
            </a>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card p-4 shadow-sm border-0">

            <h5>Servicios</h5>

            <p>
                Administración de prestaciones veterinarias.
            </p>

            <a href="/admin/servicios"
            class="btn btn-primary">
                Ver Servicios
            </a>

        </div>
    </div>
    <div class="col-md-4">
        <div class="card p-4 shadow-sm border-0">
            <h5>Alertas Auditoría</h5>
            <p>Duplicados, riesgo financiero y control antifraude.</p>

            <a href="/admin/alertas"
            class="btn btn-danger">
                Ver Alertas
            </a>
        </div>
    </div>

</div>

</div>

</body>
</html>
