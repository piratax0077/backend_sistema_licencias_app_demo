<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            if (! Schema::hasColumn('users', 'rut')) {
                $table->string('rut', 20)->nullable()->index()->after('email');
            }
            if (! Schema::hasColumn('users', 'rol')) {
                $table->string('rol', 30)->default('paciente')->index()->after('password');
            }
            if (! Schema::hasColumn('users', 'activo')) {
                $table->boolean('activo')->default(true)->index()->after('rol');
            }
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            foreach (['activo', 'rol', 'rut'] as $column) {
                if (Schema::hasColumn('users', $column)) {
                    $table->dropColumn($column);
                }
            }
        });
    }
};
