<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Support\Rut;
use Illuminate\Http\Client\ConnectionException;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

class DemoCatalogController extends Controller
{
    public function byRut(string $type, string $rut): JsonResponse
    {
        abort_unless(in_array($type, ['patients', 'professionals'], true), 404);
        $clean = Rut::clean($rut);
        abort_if($clean === null, 422, 'RUT inválido.');

        $remoteType = $type === 'patients' ? 'pacientes' : 'profesionales';
        $url = config('medsdi.api_url').'/api/integraciones/licencias/catalogo/'.$remoteType.'/rut/'.rawurlencode($clean);

        try {
            $response = Http::acceptJson()
                ->withHeader('X-Integration-Key', (string) config('medsdi.integration_key'))
                ->timeout(config('medsdi.timeout'))
                ->get($url);
        } catch (ConnectionException) {
            return response()->json(['message' => 'No fue posible conectar con el backend de Med-SDI.'], 503);
        }

        if (! $response->successful()) {
            return response()->json([
                'message' => $response->json('message') ?: 'Med-SDI no pudo completar la búsqueda.',
            ], $response->status());
        }

        $remote = $response->json('data');
        abort_unless(is_array($remote) && isset($remote['external_id'], $remote['name'], $remote['rut']), 502, 'Respuesta inválida de Med-SDI.');

        $data = DB::transaction(fn () => $type === 'patients'
            ? $this->storePatient($remote)
            : $this->storeProfessional($remote));

        return response()->json(['ok' => true, 'data' => $data]);
    }

    private function storePatient(array $remote): array
    {
        DB::table('demo_patients')->updateOrInsert(
            ['source' => 'medsdi', 'external_id' => $remote['external_id']],
            [
                'name' => $remote['name'],
                'detail' => $remote['rut'],
                'source_data' => json_encode(['estado' => $remote['status'] ?? null], JSON_UNESCAPED_UNICODE),
                'created_at' => now(),
                'updated_at' => now(),
            ]
        );

        $id = DB::table('demo_patients')->where('source', 'medsdi')
            ->where('external_id', $remote['external_id'])->value('id');

        return [
            'id' => $id,
            'name' => $remote['name'],
            'rut' => $remote['rut'],
            'detail' => $remote['rut'],
            'sites' => [],
        ];
    }

    private function storeProfessional(array $remote): array
    {
        DB::table('demo_professionals')->updateOrInsert(
            ['source' => 'medsdi', 'external_id' => $remote['external_id']],
            [
                'name' => $remote['name'],
                'detail' => $remote['specialty'] ?? 'Especialidad no informada',
                'source_data' => json_encode([
                    'rut' => $remote['rut'],
                    'estado' => $remote['status'] ?? null,
                    'certificado' => $remote['certified'] ?? null,
                    'id_especialidad' => $remote['specialty_id'] ?? null,
                ], JSON_UNESCAPED_UNICODE),
                'created_at' => now(),
                'updated_at' => now(),
            ]
        );

        $professionalId = DB::table('demo_professionals')->where('source', 'medsdi')
            ->where('external_id', $remote['external_id'])->value('id');
        $localSites = [];

        foreach ($remote['sites'] ?? [] as $site) {
            $address = trim((string) ($site['address'] ?? ''));
            $label = implode(' · ', array_filter([$site['name'] ?? null, $address, $site['city'] ?? null]));
            DB::table('demo_sites')->updateOrInsert(
                ['source' => 'medsdi', 'external_id' => $site['external_id']],
                [
                    'name' => $label ?: 'Lugar Med-SDI #'.$site['external_id'],
                    'detail' => 'presencial',
                    'source_data' => json_encode($site, JSON_UNESCAPED_UNICODE),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]
            );

            $siteId = DB::table('demo_sites')->where('source', 'medsdi')
                ->where('external_id', $site['external_id'])->value('id');
            DB::table('demo_professional_sites')->updateOrInsert(
                ['professional_id' => $professionalId, 'site_id' => $siteId],
                [
                    'source' => 'medsdi',
                    'external_id' => $site['relation_id'] ?? null,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]
            );
            $localSites[] = ['id' => $siteId, 'name' => $label, 'detail' => 'presencial'];
        }

        DB::table('demo_professional_sites')->where('professional_id', $professionalId)
            ->where('source', 'medsdi')
            ->when($localSites, fn ($query) => $query->whereNotIn('site_id', array_column($localSites, 'id')))
            ->when(! $localSites, fn ($query) => $query)
            ->delete();

        return [
            'id' => $professionalId,
            'name' => $remote['name'],
            'rut' => $remote['rut'],
            'detail' => $remote['specialty'] ?? 'Especialidad no informada',
            'sites' => $localSites,
        ];
    }
}
