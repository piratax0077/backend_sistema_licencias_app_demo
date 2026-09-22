<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void {
        Schema::create('demo_licencia_cases', function (Blueprint $table) {
            $table->id();
            $table->string('folio')->unique();
            $table->string('status')->index();
            $table->unsignedInteger('version')->default(1);
            $table->json('data');
            $table->timestamps();
        });
    }
    public function down(): void { Schema::dropIfExists('demo_licencia_cases'); }
};
