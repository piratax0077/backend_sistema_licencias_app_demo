<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;
return new class extends Migration {
 public function up():void {Schema::create('demo_review_settings',function(Blueprint $t){$t->id();$t->json('data');$t->timestamps();});DB::table('demo_review_settings')->insert(['id'=>1,'data'=>json_encode(['radius_km'=>1,'review_from'=>2,'max_days'=>14,'min_minutes'=>10,'check_origin'=>true,'check_location'=>true,'max_accuracy'=>200]),'created_at'=>now(),'updated_at'=>now()]);}
 public function down():void {Schema::dropIfExists('demo_review_settings');}
};
