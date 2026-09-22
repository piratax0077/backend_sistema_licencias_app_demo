<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DemoLicenciaCase extends Model
{
    protected $table = 'demo_licencia_cases';
    protected $guarded = [];
    protected $casts = ['data' => 'array', 'version' => 'integer'];
}
