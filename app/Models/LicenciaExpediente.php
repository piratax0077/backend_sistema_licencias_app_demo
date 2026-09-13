<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class LicenciaExpediente extends Model
{
    protected $table = 'licencia_expedientes';

    protected $fillable = [
        'folio',
        'estado',
        'origen',
        'tipo_licencia',
        'dias_reposo',
        'fecha_emision',
        'fecha_inicio_reposo',
        'fecha_fin_reposo',
        'diagnostico_codigo',
        'diagnostico_descripcion',
        'metadata',
    ];

    protected $casts = [
        'fecha_emision' => 'date',
        'fecha_inicio_reposo' => 'date',
        'fecha_fin_reposo' => 'date',
        'metadata' => 'array',
    ];

    public function paciente(): HasOne
    {
        return $this->hasOne(LicenciaPaciente::class, 'expediente_id');
    }

    public function profesional(): HasOne
    {
        return $this->hasOne(LicenciaProfesional::class, 'expediente_id');
    }

    public function autorizacionPaciente(): HasOne
    {
        return $this->hasOne(LicenciaPacienteAutorizacion::class, 'expediente_id');
    }

    public function empleadores(): HasMany
    {
        return $this->hasMany(LicenciaEmpleador::class, 'expediente_id');
    }

    public function documentosRequeridos(): HasMany
    {
        return $this->hasMany(LicenciaDocumentoRequerido::class, 'expediente_id');
    }

    public function eventos(): HasMany
    {
        return $this->hasMany(LicenciaEvento::class, 'expediente_id');
    }
}
