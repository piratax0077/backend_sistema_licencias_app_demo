<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('licencia_expedientes', function (Blueprint $table) {
            $table->id();
            $table->string('folio')->unique();
            $table->string('estado', 60)->default('pendiente_autorizacion_paciente')->index();
            $table->string('origen', 60)->default('licencia_blade');
            $table->string('tipo_licencia', 80)->nullable();
            $table->unsignedInteger('dias_reposo')->nullable();
            $table->date('fecha_emision')->nullable();
            $table->date('fecha_inicio_reposo')->nullable();
            $table->date('fecha_fin_reposo')->nullable();
            $table->string('diagnostico_codigo', 40)->nullable();
            $table->text('diagnostico_descripcion')->nullable();
            $table->json('metadata')->nullable();
            $table->timestamps();
        });

        Schema::create('licencia_pacientes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('expediente_id')->constrained('licencia_expedientes')->cascadeOnDelete();
            $table->string('rut', 20)->index();
            $table->string('nombre');
            $table->string('email')->nullable();
            $table->string('telefono', 30)->nullable();
            $table->string('direccion')->nullable();
            $table->string('prevision', 80)->nullable();
            $table->timestamps();
        });

        Schema::create('licencia_profesionales', function (Blueprint $table) {
            $table->id();
            $table->foreignId('expediente_id')->constrained('licencia_expedientes')->cascadeOnDelete();
            $table->string('rut', 20)->nullable();
            $table->string('nombre');
            $table->string('especialidad')->nullable();
            $table->string('email')->nullable();
            $table->string('firma_hash')->nullable();
            $table->timestamp('emitida_at')->nullable();
            $table->timestamps();
        });

        Schema::create('licencia_paciente_autorizaciones', function (Blueprint $table) {
            $table->id();
            $table->foreignId('expediente_id')->constrained('licencia_expedientes')->cascadeOnDelete();
            $table->string('token', 100)->unique();
            $table->string('canal', 40)->default('app_licencias_reposo');
            $table->string('estado', 40)->default('pendiente')->index();
            $table->timestamp('solicitada_at')->nullable();
            $table->timestamp('respondida_at')->nullable();
            $table->text('respuesta_observacion')->nullable();
            $table->json('payload_app')->nullable();
            $table->timestamps();
        });

        Schema::create('licencia_empleadores', function (Blueprint $table) {
            $table->id();
            $table->foreignId('expediente_id')->constrained('licencia_expedientes')->cascadeOnDelete();
            $table->string('rut', 20)->nullable()->index();
            $table->string('razon_social');
            $table->string('email')->nullable();
            $table->string('telefono', 30)->nullable();
            $table->string('direccion')->nullable();
            $table->boolean('afiliado_ccaf')->default(false);
            $table->string('ccaf_nombre')->nullable();
            $table->string('estado', 50)->default('bloqueado_por_autorizacion')->index();
            $table->timestamp('consultado_at')->nullable();
            $table->timestamp('notificado_at')->nullable();
            $table->timestamp('documentacion_preparada_at')->nullable();
            $table->timestamps();
        });

        Schema::create('licencia_empleador_notificaciones', function (Blueprint $table) {
            $table->id();
            $table->foreignId('empleador_id')->constrained('licencia_empleadores')->cascadeOnDelete();
            $table->string('canal', 40)->default('email');
            $table->string('destinatario');
            $table->string('estado', 40)->default('pendiente')->index();
            $table->string('asunto')->nullable();
            $table->text('mensaje')->nullable();
            $table->timestamp('enviada_at')->nullable();
            $table->timestamps();
        });

        Schema::create('licencia_documentos_requeridos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('expediente_id')->constrained('licencia_expedientes')->cascadeOnDelete();
            $table->foreignId('empleador_id')->nullable()->constrained('licencia_empleadores')->nullOnDelete();
            $table->string('codigo', 80)->index();
            $table->string('nombre');
            $table->text('descripcion')->nullable();
            $table->boolean('obligatorio')->default(true);
            $table->string('estado', 40)->default('pendiente')->index();
            $table->timestamps();
        });

        Schema::create('licencia_documentos_adjuntos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('documento_requerido_id')->constrained('licencia_documentos_requeridos')->cascadeOnDelete();
            $table->string('archivo_path');
            $table->string('nombre_original')->nullable();
            $table->string('mime', 120)->nullable();
            $table->unsignedBigInteger('tamano')->nullable();
            $table->string('estado', 40)->default('adjunto')->index();
            $table->timestamp('adjuntado_at')->nullable();
            $table->timestamps();
        });

        Schema::create('licencia_reposo_dispositivos', function (Blueprint $table) {
            $table->id();
            $table->string('paciente_rut', 20)->index();
            $table->string('device_token')->unique();
            $table->string('plataforma', 40)->nullable();
            $table->string('app_version', 40)->nullable();
            $table->timestamp('ultimo_contacto_at')->nullable();
            $table->timestamps();
        });

        Schema::create('licencia_eventos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('expediente_id')->constrained('licencia_expedientes')->cascadeOnDelete();
            $table->string('actor', 60)->nullable();
            $table->string('accion');
            $table->text('detalle')->nullable();
            $table->json('metadata')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('licencia_eventos');
        Schema::dropIfExists('licencia_reposo_dispositivos');
        Schema::dropIfExists('licencia_documentos_adjuntos');
        Schema::dropIfExists('licencia_documentos_requeridos');
        Schema::dropIfExists('licencia_empleador_notificaciones');
        Schema::dropIfExists('licencia_empleadores');
        Schema::dropIfExists('licencia_paciente_autorizaciones');
        Schema::dropIfExists('licencia_profesionales');
        Schema::dropIfExists('licencia_pacientes');
        Schema::dropIfExists('licencia_expedientes');
    }
};
