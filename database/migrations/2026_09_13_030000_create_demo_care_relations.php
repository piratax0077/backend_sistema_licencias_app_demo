<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
return new class extends Migration {
 public function up():void {Schema::create('demo_care_relations',function(Blueprint $t){$t->id();$t->foreignId('patient_id')->constrained('demo_patients')->cascadeOnDelete();$t->foreignId('professional_id')->constrained('demo_professionals')->cascadeOnDelete();$t->foreignId('site_id')->constrained('demo_sites')->cascadeOnDelete();$t->unique(['patient_id','professional_id','site_id'],'demo_care_relation_unique');$t->timestamps();});}
 public function down():void {Schema::dropIfExists('demo_care_relations');}
};
