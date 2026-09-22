<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
return new class extends Migration {
 public function up():void {Schema::create('demo_workflow_audits',function(Blueprint $t){$t->id();$t->string('folio');$t->string('action');$t->string('role');$t->string('channel');$t->string('result');$t->string('status');$t->text('reason')->nullable();$t->timestamps();});}
 public function down():void {Schema::dropIfExists('demo_workflow_audits');}
};
