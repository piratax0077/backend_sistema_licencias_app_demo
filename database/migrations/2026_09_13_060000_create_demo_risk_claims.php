<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
return new class extends Migration {
 public function up():void {
  Schema::create('demo_bono_claims',function(Blueprint $t){$t->string('bono',150)->primary();$t->foreignId('case_id')->constrained('demo_licencia_cases')->cascadeOnDelete();$t->timestamp('created_at');});
  Schema::create('demo_payment_claims',function(Blueprint $t){$t->string('folio')->primary();$t->unsignedBigInteger('case_id')->unique();$t->timestamp('created_at');});
 }
 public function down():void {Schema::dropIfExists('demo_bono_claims');Schema::dropIfExists('demo_payment_claims');}
};
