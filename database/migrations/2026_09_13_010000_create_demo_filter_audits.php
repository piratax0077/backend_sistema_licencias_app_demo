<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
return new class extends Migration {
 public function up():void {Schema::create('demo_filter_audits',function(Blueprint $t){$t->id();$t->foreignId('case_id')->nullable()->constrained('demo_licencia_cases')->nullOnDelete();$t->string('folio');$t->string('patient');$t->boolean('passed');$t->json('snapshot');$t->json('reasons');$t->text('patient_notification')->nullable();$t->timestamp('reviewed_at')->nullable();$t->text('review_note')->nullable();$t->timestamps();});}
 public function down():void {Schema::dropIfExists('demo_filter_audits');}
};
