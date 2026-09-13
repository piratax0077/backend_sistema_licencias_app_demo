<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>Dashboard Tótems VETERCHILE</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-4">
    <h1>Dashboard Tótems VETERCHILE</h1>

    <div class="row mt-4">
        <div class="col-md-3">
            <div class="card p-3">
                <h5>Tótems activos</h5>
                <h2 id="totems_activos">0</h2>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-3">
                <h5>Ventas hoy</h5>
                <h2 id="ventas_hoy">0</h2>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-3">
                <h5>Monto hoy</h5>
                <h2 id="monto_hoy">$0</h2>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card p-3">
                <h5>Vouchers emitidos</h5>
                <h2 id="vouchers_emitidos">0</h2>
            </div>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-md-6">
            <div class="card p-3">
                <h4>Top Prestadores</h4>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Prestador</th>
                            <th>Ventas</th>
                            <th>Monto</th>
                        </tr>
                    </thead>
                    <tbody id="tabla_prestadores"></tbody>
                </table>
            </div>
        </div>
    </div>

    <h3 class="mt-5">Últimas ventas</h3>
    <table class="table table-bordered mt-3">
        <thead>
            <tr>
                <th>ID</th>
                <th>Tótem</th>
                <th>Cliente</th>
                <th>Total</th>
                <th>Estado</th>
                <th>Fecha</th>
            </tr>
        </thead>
        <tbody id="tabla_ventas"></tbody>
    </table>

    <div class="card p-3 mt-4">
        <h4>Estado de Tótems</h4>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Código</th>
                    <th>Nombre</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody id="tabla_totems"></tbody>
        </table>
    </div>
    <div class="col-md-3">
        <div class="card p-3">
            <h5>Clientes Nuevos</h5>
            <h2 id="clientes_nuevos_hoy">0</h2>
        </div>
    </div>
    <div class="col-md-3">
        <div class="card p-3">
            <h5>Conversión</h5>
            <h2 id="tasa_conversion">0%</h2>
        </div>
    </div>
    <div class="card p-3 mt-4">
        <h4>Top Clientes</h4>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Cliente</th>
                    <th>Compras</th>
                    <th>Monto</th>
                </tr>
            </thead>

            <tbody id="tabla_clientes"></tbody>
        </table>
    </div>
</div>
<script>
async function cargarDashboard() {

    try {

        const login = await fetch('/api/totem/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                codigo: 'TOTEM001'
            })
        });

        const dataLogin = await login.json();

        const res = await fetch('/api/totem/dashboard', {
            headers: {
                'X-TOTEM-TOKEN': dataLogin.token
            }
        });

        const data = await res.json();

        console.log('Dashboard cargado:', data);

        // KPIs

        document.getElementById('totems_activos').innerText =
            data.resumen.totems_activos;

        document.getElementById('ventas_hoy').innerText =
            data.resumen.ventas_hoy;

        document.getElementById('monto_hoy').innerText =
            '$' + Number(data.resumen.monto_hoy).toLocaleString('es-CL');

        document.getElementById('vouchers_emitidos').innerText =
            data.resumen.vouchers_emitidos;

        document.getElementById('tasa_conversion').innerText =
            data.resumen.tasa_conversion + '%';

        if (data.clientes_nuevos_hoy !== undefined) {

            document.getElementById(
                'clientes_nuevos_hoy'
            ).innerText = data.clientes_nuevos_hoy;
        }

        // Últimas ventas

        let htmlVentas = '';

        data.ultimas_ventas.forEach(v => {

            htmlVentas += `
            <tr>
                <td>${v.id}</td>
                <td>${v.totem_id}</td>
                <td>${v.cliente_nombre ?? 'Invitado'}</td>
                <td>$${Number(v.total).toLocaleString('es-CL')}</td>
                <td>${v.estado}</td>
                <td>${v.created_at}</td>
            </tr>`;
        });

        document.getElementById(
            'tabla_ventas'
        ).innerHTML = htmlVentas;

        // Top Prestadores

        let htmlPrestadores = '';

        data.top_prestadores.forEach(p => {

            htmlPrestadores += `
            <tr>
                <td>${p.prestador_nombre}</td>
                <td>${p.ventas}</td>
                <td>$${Number(p.monto).toLocaleString('es-CL')}</td>
            </tr>`;
        });

        document.getElementById(
            'tabla_prestadores'
        ).innerHTML = htmlPrestadores;

        // Estado Tótems

        let htmlTotems = '';

        data.totems.forEach(t => {

            let estado = '🔴 Offline';

            if (t.ultimo_ping) {

                const ultimoPing = new Date(t.ultimo_ping);
                const ahora = new Date();

                const diffMin =
                    (ahora - ultimoPing) / 1000 / 60;

                if (diffMin <= 2) {

                    estado = '🟢 Online';

                } else if (diffMin <= 10) {

                    estado = '🟡 Inactivo';
                }
            }

            htmlTotems += `
            <tr>
                <td>${t.id}</td>
                <td>${t.codigo}</td>
                <td>${t.nombre}</td>
                <td>${estado}</td>
            </tr>`;
        });

        document.getElementById(
            'tabla_totems'
        ).innerHTML = htmlTotems;

        // Top Clientes

        if (data.top_clientes) {

            let htmlClientes = '';

            data.top_clientes.forEach(c => {

                htmlClientes += `
                <tr>
                    <td>${c.cliente_nombre ?? 'Sin nombre'}</td>
                    <td>${c.compras}</td>
                    <td>$${Number(c.monto).toLocaleString('es-CL')}</td>
                </tr>`;
            });

            document.getElementById(
                'tabla_clientes'
            ).innerHTML = htmlClientes;
        }

    } catch (error) {

        console.error(
            'Error al cargar dashboard:',
            error
        );
    }
}

// Carga inicial

cargarDashboard();

// Actualiza cada 30 segundos

setInterval(
    cargarDashboard,
    30000
);
</script>


</body>
</html>
