<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        foreach (['demo_patients', 'demo_professionals', 'demo_sites'] as $table) {
            Schema::table($table, function (Blueprint $blueprint) use ($table) {
                $blueprint->string('source', 40)->nullable()->after('detail');
                $blueprint->unsignedBigInteger('external_id')->nullable()->after('source');
                $blueprint->json('source_data')->nullable()->after('external_id');
                $blueprint->unique(['source', 'external_id'], $table.'_source_external_unique');
            });
        }

        Schema::create('demo_professional_sites', function (Blueprint $table) {
            $table->id();
            $table->foreignId('professional_id')->constrained('demo_professionals')->cascadeOnDelete();
            $table->foreignId('site_id')->constrained('demo_sites')->cascadeOnDelete();
            $table->string('source', 40)->nullable();
            $table->unsignedBigInteger('external_id')->nullable();
            $table->timestamps();
            $table->unique(['professional_id', 'site_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('demo_professional_sites');
        foreach (['demo_patients', 'demo_professionals', 'demo_sites'] as $table) {
            Schema::table($table, function (Blueprint $blueprint) use ($table) {
                $blueprint->dropUnique($table.'_source_external_unique');
                $blueprint->dropColumn(['source', 'external_id', 'source_data']);
            });
        }
    }
};
