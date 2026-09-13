(function () {
    "use strict";

    function apiBaseUrl() {
        return (window.VETERCHILE_CONFIG && window.VETERCHILE_CONFIG.apiBaseUrl) ||
            "http://127.0.0.1:8024/api/licencias-reposo";
    }

    async function apiPost(path, body) {
        const response = await fetch(apiBaseUrl() + path, {
            method: "POST",
            headers: {
                "Accept": "application/json",
                "Content-Type": "application/json",
            },
            body: JSON.stringify(body || {}),
        });

        const payload = await response.json().catch(() => null);
        if (!response.ok) {
            throw new Error((payload && payload.message) || "No se pudo conectar con API Licencias Reposo.");
        }
        return payload;
    }

    window.LicenciasReposoApi = {
        registrarDispositivo(pacienteRut, deviceToken, extra) {
            return apiPost("/dispositivos", Object.assign({
                paciente_rut: pacienteRut,
                device_token: deviceToken,
                plataforma: "cordova-pwa",
                app_version: "1.0.0",
            }, extra || {}));
        },

        pendientes(pacienteRut) {
            return apiPost("/pendientes", {
                paciente_rut: pacienteRut,
            });
        },

        responder(token, aprueba, observacion) {
            return apiPost("/autorizaciones/" + encodeURIComponent(token) + "/responder", {
                aprueba: Boolean(aprueba),
                observacion: observacion || null,
            });
        },
    };
}());
