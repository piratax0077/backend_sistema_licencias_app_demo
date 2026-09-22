<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
return new class extends Migration {
 public function up(): void {
  foreach (['patients','professionals','sites'] as $type) Schema::create('demo_'.$type,function(Blueprint $t) use($type){$t->id();$t->string('name');$t->string('detail');$t->timestamps();});
  Schema::create('demo_consultations',function(Blueprint $t){
   $t->id(); foreach(['patient'=>'patients','professional'=>'professionals','site'=>'sites'] as $key=>$table) $t->foreignId($key.'_id')->constrained('demo_'.$table)->restrictOnDelete();
   $t->dateTime('appointment_at')->nullable(); $t->string('appointment_mode')->nullable();
   $t->dateTime('started_at');$t->dateTime('ended_at');$t->string('mode');$t->string('bono')->nullable();$t->boolean('bono_verified')->default(false);
   $t->string('decision');$t->text('diagnosis');$t->unsignedInteger('days')->nullable();$t->date('start')->nullable();$t->string('insurance');$t->string('address');
   $t->foreignId('case_id')->nullable()->unique()->constrained('demo_licencia_cases')->nullOnDelete();$t->timestamps();
  });
 }
 public function down(): void {Schema::dropIfExists('demo_consultations');foreach(['patients','professionals','sites'] as $type) Schema::dropIfExists('demo_'.$type);}
};
