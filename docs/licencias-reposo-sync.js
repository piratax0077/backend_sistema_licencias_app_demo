(function () {
    "use strict";

    async function syncLicenciasReposo() {
        if (!window.LicenciasReposoApi) {
            return;
        }

        var rutInput = document.getElementById("patientRut");
        var rut = rutInput && rutInput.value ? rutInput.value.trim() : "12.345.678-9";
        var deviceToken = typeof getOrCreateDeviceId === "function"
            ? getOrCreateDeviceId()
            : "licencias-reposo-web-demo";

        try {
            await window.LicenciasReposoApi.registrarDispositivo(rut, deviceToken);
            var pendientes = await window.LicenciasReposoApi.pendientes(rut);
            var count = Array.isArray(pendientes.data) ? pendientes.data.length : 0;

            if (typeof addAuditEvent === "function") {
                addAuditEvent({
                    actor: "API Licencias Reposo",
                    type: "Sincronizacion",
                    detail: "Dispositivo registrado y " + count + " autorizacion(es) pendiente(s) recibida(s).",
                    status: count > 0 ? "alert" : "ok",
                });
            }

            window.LICENCIAS_REPOSO_PENDIENTES = pendientes.data || [];
        } catch (error) {
            if (typeof addAuditEvent === "function") {
                addAuditEvent({
                    actor: "API Licencias Reposo",
                    type: "Conexion fallida",
                    detail: error.message || "No se pudo sincronizar con Laravel.",
                    status: "alert",
                });
            }
        }
    }

    window.sincronizarLicenciasReposo = syncLicenciasReposo;
    window.responderLicenciaReposo = async function (token, aprueba, observacion) {
        var response = await window.LicenciasReposoApi.responder(token, aprueba, observacion || null);
        await syncLicenciasReposo();
        return response;
    };

    document.addEventListener("DOMContentLoaded", function () {
        window.setTimeout(syncLicenciasReposo, 1200);
    });
}());
