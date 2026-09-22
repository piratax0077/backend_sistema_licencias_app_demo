<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
return new class extends Migration {
 public function up():void {Schema::table('demo_consultations',fn(Blueprint $t)=>$t->boolean('professional_enabled')->default(false));}
 public function down():void {Schema::table('demo_consultations',fn(Blueprint $t)=>$t->dropColumn('professional_enabled'));}
};
