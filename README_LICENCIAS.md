# SDI Licencias

Proyecto Laravel 13 con PHP 8.4 para emitir licencias medicas, solicitar autorizacion al paciente, notificar empleadores y conectar la app Licencias Reposo.

## Docker

```bash
cp .env.example .env
docker compose up -d --build
docker compose exec app php artisan migrate --seed
```

- Aplicación: `http://localhost:8024`
- Formulario: `http://localhost:8024/licencia`
- Licencias del empleador: `http://localhost:8024/empleador/licencias`
- Mailpit: `http://localhost:8026`

## Ver formulario

```powershell
cd "C:\Users\Jaime\Desktop\proyectos\sistema de voucher\licencias-laravel13"
.\tools\php-8.4.22-Win32-vs17-x64\php.exe artisan serve --host=127.0.0.1 --port=8024
```

Abrir:

- `http://127.0.0.1:8024/licencia`
- `http://127.0.0.1:8024/empleador/licencias`

## Flujo

1. Se crea la licencia desde `resources/views/licencia.blade.php` o por API.
2. El sistema crea expediente, paciente, profesional, empleadores y documentos requeridos.
3. Los empleadores quedan bloqueados en estado `bloqueado_por_autorizacion`.
4. El paciente autoriza desde URL web o desde la app Licencias Reposo.
5. Al aprobar, los empleadores pasan a `notificado_preparar_documentos`.
6. El empleador consulta pendientes y prepara/adjunta documentacion.

## API principal

- `POST /api/licencias/emitir`
- `GET /api/licencias/{folio}`
- `POST /api/licencias/autorizaciones/{token}/responder`
- `GET /api/licencias/empleadores/{rut}/pendientes`
- `POST /api/licencias/empleadores/{empleador}/preparar-documentacion`
- `POST /api/licencias/documentos/{documento}/adjuntar`

## API app Licencias Reposo

- `POST /api/licencias-reposo/dispositivos`
- `POST /api/licencias-reposo/pendientes`
- `POST /api/licencias-reposo/autorizaciones/{token}/responder`

La app en `C:\Users\Jaime\Desktop\proyectos\licencias-reposo-apk` queda apuntando a:

```js
http://127.0.0.1:8024/api/licencias-reposo
```

## Base de datos

En Docker se utiliza MySQL 8.4 mediante el servicio `mysql`. Sus datos se
conservan en el volumen `licencias_mysql`, aunque los contenedores se reinicien.

Las migraciones crean las tablas del flujo de licencias SDI.

## App de paciente integrada

Con el repositorio hermano `licencias_app_demo` clonado junto a este proyecto,
Docker monta `app-paciente` en modo solo lectura y Laravel sirve la misma fuente
usada por Cordova:

- Portal demo: `http://localhost:8024/`
- App del paciente: `http://localhost:8024/app`
- Fiscalización: `http://localhost:8024/fiscalizacion`

Desde un expediente del portal, el botón **Abrir app de control** genera un
enlace firmado exclusivo para ese caso. Las acciones se sincronizan mediante
`/api/demo-app/expedientes/{id}`.

## Catálogo inicial desde Med-SDI

El formulario de atención puede sincronizar pacientes, profesionales activos y
sus lugares de atención desde la base MySQL de `medsdi-laravel13`:

```bash
docker compose exec app php artisan medsdi:import-catalog --patients=20 --professionals=20
```

La importación conserva los IDs externos y es idempotente. Es solo una carga
inicial: las búsquedas por RUT de la pantalla consultan en línea el API del
backend Laravel 13 de Med-SDI, mediante las rutas protegidas:

- `GET /api/integraciones/licencias/catalogo/pacientes/rut/{rut}`
- `GET /api/integraciones/licencias/catalogo/profesionales/rut/{rut}`

Licencias conserva localmente únicamente la referencia del resultado elegido.
La respuesta del profesional incluye sus lugares activos y el selector muestra
solamente esos registros de `profesionales_lugares_atencion`.
