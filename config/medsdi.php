<?php

return [
    'api_url' => rtrim(env('MEDSDI_API_URL', 'http://medsdi-laravel13-laravel.test-1'), '/'),
    'integration_key' => env('MEDSDI_LICENCIAS_INTEGRATION_KEY'),
    'timeout' => (int) env('MEDSDI_API_TIMEOUT', 8),
];
