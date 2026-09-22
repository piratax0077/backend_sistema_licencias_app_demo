<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use RuntimeException;

class ImportMedsdiCatalog extends Command
{
    protected $signature = 'medsdi:import-catalog {--patients=20} {--professionals=20}';

    protected $description = 'Importa pacientes, profesionales y sus lugares activos desde Med-SDI';

    public function handle(): int
    {
        $patientLimit = max(20, (int) $this->option('patients'));
        $professionalLimit = max(20, (int) $this->option('professionals'));
        $source = DB::connection('medsdi_source');

        $patients = $source->table('pacientes')
            ->whereNotNull('rut')
            ->orderBy('id')
            ->limit($patientLimit)
            ->get(['id', 'rut', 'nombres', 'apellido_uno', 'apellido_dos', 'estado']);

        $professionals = $source->table('profesionales as p')
            ->join('profesionales_lugares_atencion as relation', function ($join) {
                $join->on('relation.id_profesional', '=', 'p.id')->where('relation.estado', 1);
            })
            ->leftJoin('especialidades as specialty', 'specialty.id', '=', 'p.id_especialidad')
            ->where('p.estado', 1)
            ->orderBy('p.id')
            ->distinct()
            ->limit($professionalLimit)
            ->get([
                'p.id', 'p.rut', 'p.nombre', 'p.apellido_uno', 'p.apellido_dos',
                'p.estado', 'p.certificado', 'p.id_especialidad', 'specialty.nombre as specialty_name',
            ]);

        if ($patients->count() < 20 || $professionals->count() < 20) {
            throw new RuntimeException('Med-SDI no devolvió el mínimo de 20 pacientes y 20 profesionales con lugar activo.');
        }

        $professionalIds = $professionals->pluck('id');
        $relations = $source->table('profesionales_lugares_atencion as relation')
            ->join('lugares_atencion as site', 'site.id', '=', 'relation.id_lugar_atencion')
            ->leftJoin('direcciones as address', 'address.id', '=', 'site.id_direccion')
            ->leftJoin('ciudades as city', 'city.id', '=', 'address.id_ciudad')
            ->where('relation.estado', 1)
            ->whereIn('relation.id_profesional', $professionalIds)
            ->orderBy('site.nombre')
            ->get([
                'relation.id as relation_id', 'relation.id_profesional',
                'site.id as site_id', 'site.nombre as site_name', 'site.tipo',
                'address.direccion', 'address.numero_dir', 'city.nombre as city_name',
            ]);

        DB::connection('mysql')->transaction(function () use ($patients, $professionals, $relations) {
            foreach ($patients as $patient) {
                DB::table('demo_patients')->updateOrInsert(
                    ['source' => 'medsdi', 'external_id' => $patient->id],
                    [
                        'name' => $this->fullName($patient->nombres, $patient->apellido_uno, $patient->apellido_dos),
                        'detail' => $patient->rut,
                        'source_data' => json_encode(['estado' => (int) $patient->estado], JSON_UNESCAPED_UNICODE),
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]
                );
            }

            foreach ($professionals as $professional) {
                DB::table('demo_professionals')->updateOrInsert(
                    ['source' => 'medsdi', 'external_id' => $professional->id],
                    [
                        'name' => $this->fullName($professional->nombre, $professional->apellido_uno, $professional->apellido_dos),
                        'detail' => $professional->specialty_name ?: 'Especialidad no informada',
                        'source_data' => json_encode([
                            'rut' => $professional->rut,
                            'estado' => (int) $professional->estado,
                            'certificado' => (int) $professional->certificado,
                            'id_especialidad' => $professional->id_especialidad,
                        ], JSON_UNESCAPED_UNICODE),
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]
                );
            }

            foreach ($relations as $relation) {
                $address = trim(implode(' ', array_filter([$relation->direccion, $relation->numero_dir])));
                $label = implode(' · ', array_filter([$relation->site_name, $address, $relation->city_name]));
                DB::table('demo_sites')->updateOrInsert(
                    ['source' => 'medsdi', 'external_id' => $relation->site_id],
                    [
                        'name' => $label ?: 'Lugar Med-SDI #'.$relation->site_id,
                        'detail' => 'presencial',
                        'source_data' => json_encode([
                            'tipo' => $relation->tipo,
                            'direccion' => $address,
                            'ciudad' => $relation->city_name,
                        ], JSON_UNESCAPED_UNICODE),
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]
                );

                $professionalId = DB::table('demo_professionals')
                    ->where('source', 'medsdi')->where('external_id', $relation->id_profesional)->value('id');
                $siteId = DB::table('demo_sites')
                    ->where('source', 'medsdi')->where('external_id', $relation->site_id)->value('id');

                DB::table('demo_professional_sites')->updateOrInsert(
                    ['professional_id' => $professionalId, 'site_id' => $siteId],
                    [
                        'source' => 'medsdi',
                        'external_id' => $relation->relation_id,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ]
                );
            }
        });

        $this->info(sprintf(
            'Importados desde Med-SDI: %d pacientes, %d profesionales, %d lugares y %d relaciones profesional-lugar.',
            $patients->count(),
            $professionals->count(),
            $relations->pluck('site_id')->unique()->count(),
            $relations->count()
        ));

        return self::SUCCESS;
    }

    private function fullName(?string ...$parts): string
    {
        return trim(implode(' ', array_filter(array_map(fn ($part) => trim((string) $part), $parts))));
    }
}
