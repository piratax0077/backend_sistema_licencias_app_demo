<?php
namespace App\Http\Controllers;

use App\Models\DemoLicenciaCase;
use App\Services\DemoLicenciaService;
use App\Support\Rut;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class DemoAppController extends Controller
{
    public static function credential(DemoLicenciaCase $case): string
    {
        return hash_hmac('sha256', 'demo-app-paciente:'.$case->id.':'.$case->folio, (string) config('app.key'));
    }
    public static function link(DemoLicenciaCase $case): string
    {
        return url('/app').'#vincular='.$case->id.'.'.self::credential($case);
    }
    private function authorizeCase(Request $request, DemoLicenciaCase $case): void
    {
        abort_unless(hash_equals(self::credential($case), (string) $request->bearerToken()), 403, 'Vinculación no válida. Abre la app desde el expediente.');
    }
    private function authorizePatient(Request $request, DemoLicenciaCase $case): void
    {
        abort_unless(
            $request->user()?->tokenCan('patient-app')
            && $request->user()->rol === 'paciente'
            && Rut::clean($request->user()->rut) === Rut::clean($case->data['rut'] ?? null),
            403,
            'No tienes acceso a esta licencia.'
        );
    }
    public function patientIndex(Request $request)
    {
        abort_unless($request->user()?->tokenCan('patient-app'), 403);
        $rut = Rut::clean($request->user()->rut);
        $cases = DemoLicenciaCase::latest('id')->get()
            ->filter(fn (DemoLicenciaCase $case) => Rut::clean($case->data['rut'] ?? null) === $rut)
            ->map(fn (DemoLicenciaCase $case) => $this->payload($case))
            ->values();

        return response()->json(['data' => $cases])->header('Cache-Control', 'no-store');
    }
    public function patientShow(Request $request, DemoLicenciaCase $case)
    {
        $this->authorizePatient($request, $case);
        return response()->json(['data'=>$this->payload($case)])->header('Cache-Control','no-store');
    }
    public function patientAction(Request $request, DemoLicenciaCase $case, DemoLicenciaService $flow)
    {
        $this->authorizePatient($request, $case);
        return $this->performAction($request, $case, $flow);
    }
    public function show(Request $request, DemoLicenciaCase $case)
    {
        $this->authorizeCase($request, $case);
        return response()->json(['data'=>$this->payload($case)])->header('Cache-Control','no-store');
    }
    public function action(Request $request, DemoLicenciaCase $case, DemoLicenciaService $flow)
    {
        $this->authorizeCase($request, $case);
        return $this->performAction($request, $case, $flow);
    }
    private function performAction(Request $request, DemoLicenciaCase $case, DemoLicenciaService $flow)
    {
        $input=$request->validate([
            'action'=>['required',Rule::in(['autorizar','no_autorizar','ficha','control','apelar','responder_control','explicar_revision'])],
            'control_request_id'=>'nullable|uuid','decision'=>'nullable|in:aprobar,rechazar','version'=>'required|integer|min:1', 'note'=>'nullable|string|max:1000',
            'kind'=>'nullable|in:ubicacion,camara', 'consent_control'=>'nullable|in:1',
            'capture_type'=>'nullable|in:simulated,geolocation,camera',
            'latitude'=>'required_if:capture_type,geolocation|nullable|numeric|between:-90,90',
            'longitude'=>'required_if:capture_type,geolocation|nullable|numeric|between:-180,180',
            'accuracy'=>'required_if:capture_type,geolocation|nullable|numeric|min:0|max:10000000',
        ]);
        $case=$flow->act($case,$input['action'],'paciente',$input+['channel'=>'app'],(int)$input['version']);
        return response()->json(['message'=>'Guardado en el sistema de licencias.','data'=>$this->payload($case)])->header('Cache-Control','no-store');
    }
    private function payload(DemoLicenciaCase $case): array
    {
        $d=$case->data; $flow=app(DemoLicenciaService::class);
        return [
            'simulation'=>['latitude'=>-33.4489-($case->id%10)*0.001,'longitude'=>-70.6693-($case->id%10)*0.001,'diagnosis'=>$d['diagnosis'],'rest_type'=>'Total','diagnosis_status'=>'En estudio','source'=>'Datos ficticios vinculados a esta licencia'],'id'=>$case->id,'folio'=>$case->folio,'status'=>$case->status,'status_label'=>DemoLicenciaService::STATES[$case->status],
            'version'=>$case->version,'patient'=>$d['patient'],'rut'=>$d['rut'],'doctor'=>$d['doctor'],
            'employer'=>$d['employer'],'start'=>$d['start'],'days'=>$d['days'],'approved_days'=>$d['approved_days'],
            'insurance'=>$d['insurance'],'address'=>$d['address'],'consent'=>$d['consent'],'chronic_consent'=>$d['chronic_consent'],
            'control_requests'=>$d['control_requests']??[],'filter_notification'=>$d['filter_notification'] ?? null,'resolution'=>$d['resolution'] ?? null,'controls'=>$d['controls'],'events'=>$d['events'],
            'documents'=>array_values($d['documents']),'payment'=>$d['payment'],'hold'=>$d['hold'],
            'appeal_entity'=>$d['appeal_entity'] ?? null,
            'next_appeal'=>$flow->appealSteps($d)[$d['appeal_level']] ?? null,
        ];
    }
    public function asset(?string $asset = null)
    {
        $asset=$asset ?: 'index.html';
        $allowed=['index.html'=>'text/html; charset=utf-8','js/config.js'=>'application/javascript','js/integracion.js'=>'application/javascript','css/integracion.css'=>'text/css'];
        abort_unless(isset($allowed[$asset]),404);
        $path=base_path('../app-paciente/www/'.$asset);
        abort_unless(is_file($path),404);
        $content=file_get_contents($path);
        if($asset==='index.html') { $content=str_replace('<!--WEB_BASE-->','<base href="'.e(url('/app')).'/">',$content); }
        return response($content,200,['Content-Type'=>$allowed[$asset],'Cache-Control'=>'no-store']);
    }
}
