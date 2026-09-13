# SDI Licencias

Proyecto Laravel 13 con PHP 8.4 para emitir licencias medicas, solicitar autorizacion al paciente, notificar empleadores y conectar la app Licencias Reposo.

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

El proyecto queda configurado con SQLite local:

```text
database/database.sqlite
```

Las migraciones ya crean las tablas del flujo de licencias SDI.
