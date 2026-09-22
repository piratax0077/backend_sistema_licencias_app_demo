<?php
namespace App\Services;

use App\Models\DemoLicenciaCase;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class DemoLicenciaService
{
    public const ROLES = ['admin'=>'Vista general', 'paciente'=>'Paciente', 'profesional'=>'Profesional', 'empleador'=>'Empleador', 'contraloria'=>'Contraloría', 'pagador'=>'Entidad pagadora', 'auditor'=>'Auditoría'];
    public const STATES = ['borrador'=>'Pendiente de emisión', 'paciente'=>'Esperando al paciente', 'empleador'=>'Documentación laboral', 'revision'=>'En contraloría', 'aprobada'=>'Aprobada · lista para pago', 'reducida'=>'Reducida · admite reclamo', 'rechazada'=>'Rechazada · admite reclamo', 'apelacion'=>'Reclamación en revisión', 'pagada'=>'Pago simulado registrado', 'cancelada'=>'No autorizada por el paciente'];
    public const DOCS = ['remuneraciones'=>'Últimas 3 remuneraciones', 'cotizaciones'=>'Historial de cotizaciones', 'contrato'=>'Contrato de trabajo'];

    public function create(array $input = []): DemoLicenciaCase
    {
        $days = (int) ($input['days'] ?? 14);
        $data = [
            'patient'=>$input['patient'] ?? 'María Demo González', 'rut'=>$input['rut'] ?? '11.111.111-1',
            'doctor'=>'Dra. Valentina Demo', 'specialty'=>'Medicina general', 'employer'=>'Servicios Demo SpA',
            'address'=>$input['address'] ?? 'Av. Demo 120, Santiago', 'email'=>'paciente@example.test',
            'insurance'=>$input['insurance'] ?? 'Fonasa', 'sector'=>'Privado', 'days'=>$days,
            'start'=>$input['start'] ?? now()->toDateString(), 'diagnosis'=>$input['diagnosis'] ?? 'Cuadro clínico ficticio para demostración',
            'verified_bono'=>false, 'verified_doctor'=>false, 'identity'=>false, 'consent'=>false, 'chronic_consent'=>false,
            'hold'=>false, 'alerts'=>[], 'documents'=>[], 'approved_days'=>null, 'monthly_net'=>900000,
            'appeal_level'=>0, 'events'=>[], 'controls'=>[], 'token'=>Str::random(40),
            'bono'=>'BON-DEMO-'.Str::upper(Str::random(6)), 'payment'=>null, 'scenario'=>$input['scenario'] ?? 'personalizado',
        ];
        $this->event($data, 'profesional', 'Expediente de demostración creado', 'Datos ficticios. Sin emisión ante operadores externos.');
        return DemoLicenciaCase::create(['folio'=>'LME-DEMO-'.Str::upper(Str::random(8)), 'status'=>'borrador', 'version'=>1, 'data'=>$data]);
    }

    public function act(DemoLicenciaCase $case, string $action, string $role, array $input, int $version): DemoLicenciaCase
    {
        try {
            return DB::transaction(function()use($case,$action,$role,$input,$version){
                $updated=$this->applyAction($case,$action,$role,$input,$version);
                if(config('demo.automatic_review',true)){
                    $updated=app(AutoReviewService::class)->refresh($updated);
                    if(in_array($action,['emitir','enviar','pagar','no_autorizar']))foreach(DemoLicenciaCase::whereKeyNot($updated->id)->whereNotIn('status',['borrador','paciente','cancelada','rechazada','pagada'])->get() as $peer){if($peer->data['rut']===$updated->data['rut']||$peer->data['doctor']===$updated->data['doctor'])app(AutoReviewService::class)->refresh($peer);}
                }
                DB::table('demo_workflow_audits')->insert(['folio'=>$case->folio,'action'=>$action,'role'=>$role,'channel'=>$input['channel']??'portal','result'=>'aceptado','status'=>$updated->status,'reason'=>'Transición y controles del demo validados','created_at'=>now(),'updated_at'=>now()]);
                return $updated;
            });
        } catch (ValidationException $e) {
            DB::table('demo_workflow_audits')->insert(['folio'=>$case->folio,'action'=>$action,'role'=>$role,'channel'=>$input['channel']??'portal','result'=>'bloqueado','status'=>$case->fresh()?->status??$case->status,'reason'=>implode(' ',array_merge(...array_values($e->errors()))),'created_at'=>now(),'updated_at'=>now()]);
            throw $e;
        }
    }
    private function applyAction(DemoLicenciaCase $case, string $action, string $role, array $input, int $version): DemoLicenciaCase
    {
        return DB::transaction(function () use ($case, $action, $role, $input, $version) {
            $case = DemoLicenciaCase::whereKey($case->id)->lockForUpdate()->firstOrFail();
            $this->check($case->version === $version, 'El expediente cambió en otra ventana. Recarga antes de continuar.');
            $data = $case->data;
            $status = $case->status;
            $note = trim((string) ($input['note'] ?? ''));
            $roleFor = [
                'explicar_revision'=>'paciente','solicitar_control'=>'contraloria','responder_control'=>'paciente','bono'=>'profesional','profesional'=>'profesional','identidad'=>'profesional','emitir'=>'profesional',
                'autorizar'=>'paciente','no_autorizar'=>'paciente','ficha'=>'paciente','control'=>'paciente',
                'documento'=>'empleador','enviar'=>'empleador','dictamen'=>'contraloria','apelar'=>'paciente',
                'resolver'=>'contraloria','pagar'=>'pagador','alerta'=>'auditor','liberar'=>'auditor',
            ];
            $this->check(isset($roleFor[$action]) && $roleFor[$action] === $role, 'Cambia al perfil responsable de esta acción.');
            $actor=session()->get('demo_operator_id',$role.'-demo');
            $riskSettings=app(AutoReviewService::class)->settings();
            if(config('demo.risk_checks',true) && !empty($riskSettings['risk_rules']['separation']) && in_array($action,['emitir','dictamen','pagar'])){foreach(['emitir','dictamen','pagar'] as $prior){$this->check($prior===$action || ($data['workflow_actors'][$prior]??null)!==$actor,'Separación de funciones: este operador ya intervino en otra función incompatible.');}}
            $label = '';
            switch ($action) {
                case 'bono': case 'profesional': case 'identidad':
                    $this->check($status === 'borrador', 'La verificación corresponde a la emisión.');
                    $field = ['bono'=>'verified_bono','profesional'=>'verified_doctor','identidad'=>'identity'][$action];
                    $this->check(!$data[$field], 'Esta verificación ya fue registrada.');
                    $data[$field] = true;
                    $label = ['bono'=>'Bono QR verificado en el simulador','profesional'=>'Habilitación y especialidad verificadas en el simulador','identidad'=>'Firma biométrica simulada confirmada'][$action];
                    break;
                case 'emitir':
                    $this->check(!isset($data['consultation_id']) || ($data['first_filter_passed'] ?? false), 'Completa la hora tomada, bono verificado y concordancia de modalidad en la atención de origen.');
                    $this->check($status === 'borrador', 'La licencia ya fue emitida.');
                    $this->check($data['verified_bono'] && $data['verified_doctor'] && $data['identity'], 'Completa bono, habilitación y firma antes de emitir.');
                    $this->check(!$data['hold'], 'Auditoría debe resolver la alerta antes de emitir.');
                    if(config('demo.risk_checks',true) && !empty($riskSettings['risk_rules']['documents']))app(RiskControlService::class)->claimBono($case);
                    $status = 'paciente'; $label = 'Emisión simulada; autorización enviada a la bandeja del paciente';
                    break;
                case 'autorizar': case 'no_autorizar':
                    $this->check($status === 'paciente', 'No hay una autorización pendiente.');
                    $data['consent'] = $action === 'autorizar';
                    $status = $data['consent'] ? 'empleador' : 'cancelada';
                    $label = $data['consent'] ? 'Paciente autoriza el envío; empleador notificado en el demo' : 'Paciente no autoriza el envío';
                    break;
                case 'explicar_revision':
                    $this->check(mb_strlen($note)>=10,'Escribe una explicación de al menos 10 caracteres.');
                    $data['risk_explanations'][]=['role'=>'paciente','text'=>$note,'at'=>now()->toIso8601String()];$label='Paciente aporta explicación para revisión humana';
                    break;
                case 'solicitar_control':
                    $this->check($data['consent'] && !in_array($status,['borrador','paciente','cancelada','rechazada']), 'La solicitud requiere una licencia autorizada por el paciente.');
                    $kind=$input['kind']??'';
                    $this->check(in_array($kind,['ubicacion','camara','ficha']), 'Selecciona ubicación, cámara o ficha clínica.');
                    $this->check(strlen($note)>=10, 'Describe el motivo del control.');
                    $requests=$data['control_requests']??[];
                    $this->check(!collect($requests)->contains(fn($r)=>$r['kind']===$kind && $r['status']==='pendiente'), 'Ya existe una solicitud pendiente para este permiso.');
                    $requests[]=['id'=>Str::uuid()->toString(),'kind'=>$kind,'reason'=>$note,'status'=>'pendiente','requested_at'=>now()->toIso8601String(),'responded_at'=>null];
                    $data['control_requests']=$requests;$label='Contraloría solicita autorización de '.$kind.' al paciente en su app';
                    break;
                case 'responder_control':
                    $this->check($data['consent'] && !in_array($status,['borrador','paciente','cancelada','rechazada']), 'El expediente no admite esta autorización.');
                    $decision=$input['decision']??'';$this->check(in_array($decision,['aprobar','rechazar']), 'Respuesta no válida.');
                    $requests=$data['control_requests']??[];$index=null;
                    foreach($requests as $i=>$r){if($r['id']===($input['control_request_id']??'')){$index=$i;break;}}
                    $this->check($index!==null,'La solicitud no pertenece a este expediente.');
                    $this->check($requests[$index]['status']==='pendiente','La solicitud ya fue respondida.');
                    $requests[$index]['status']=$decision==='aprobar'?'aprobada':'rechazada';$requests[$index]['responded_at']=now()->toIso8601String();
                    $data['control_requests']=$requests;
                    if($requests[$index]['kind']==='ficha')$data['chronic_consent']=$decision==='aprobar';
                    $label='Paciente '.($decision==='aprobar'?'aprueba':'rechaza').' solicitud de '.$requests[$index]['kind'].' de Contraloría';
                    break;
                case 'ficha':
                    $this->check(!in_array($status, ['borrador','cancelada']), 'La licencia debe estar emitida.');
                    $data['chronic_consent'] = !$data['chronic_consent'];
                    $label = $data['chronic_consent'] ? 'Paciente concede acceso a ficha crónica ficticia' : 'Paciente revoca acceso a ficha crónica ficticia';
                    break;
                case 'control':
                    $this->check($data['consent'] && !in_array($status, ['cancelada','rechazada']), 'Se requiere autorización del paciente.');
                    $this->check(($input['consent_control'] ?? '') === '1', 'Autoriza expresamente este control simulado.');
                    $kind = $input['kind'] ?? '';
                    $this->check(in_array($kind, ['ubicacion','camara']), 'Selecciona un tipo de control válido.');
                    $capture = $input['capture_type'] ?? 'simulated';
                    $this->check(in_array($capture,['simulated','geolocation','camera']), 'Tipo de captura no válido.');
                    $this->check($capture === 'simulated' || ($capture === 'geolocation' && $kind === 'ubicacion') || ($capture === 'camera' && $kind === 'camara'), 'La captura no coincide con el permiso solicitado.');
                    $control = ['type'=>$kind,'at'=>now()->toIso8601String(),'capture_type'=>$capture,'consent'=>true];
                    if ($capture === 'geolocation') {
                        $this->check(isset($input['latitude'],$input['longitude'],$input['accuracy']), 'Falta la ubicación autorizada.');
                        $control['latitude'] = (float)$input['latitude']; $control['longitude'] = (float)$input['longitude']; $control['accuracy'] = (float)$input['accuracy'];
                        $control['result'] = 'Ubicación compartida con consentimiento puntual por la app';
                    } elseif ($capture === 'camera') {
                        $control['result'] = 'App informa apertura consentida de cámara; sin foto ni video almacenado';
                    } else { $control['result'] = 'Simulación consentida; no se capturaron datos del dispositivo'; }
                    $data['controls'][] = $control;
                    $label = $capture === 'simulated' ? 'Control de '.$kind.' simulado con consentimiento puntual' : $control['result'];
                    break;
                case 'documento':
                    $this->check($status === 'empleador', 'Los documentos se preparan en la etapa del empleador.');
                    $code = $input['document'] ?? '';
                    $this->check(isset(self::DOCS[$code]), 'Documento no válido.');
                    $data['documents'][$code] = ['name'=>self::DOCS[$code], 'at'=>now()->toIso8601String(), 'source'=>'Antecedente ficticio generado en el demo'];
                    $label = 'Documento de ejemplo incorporado: '.self::DOCS[$code];
                    break;
                case 'enviar':
                    $this->check($data['consent'] && !$data['hold'], 'Se requiere aprobación del paciente y ausencia de alerta pendiente.');
                    if ($data['circuit_demo'] ?? false) {
                        $expected=[];foreach([3,2,1] as $m)$expected[]=\Carbon\Carbon::parse($data['start'])->startOfMonth()->subMonths($m)->format('Y-m');
                        $this->check(array_column($data['payrolls']??[],'period')===$expected && ($data['contribution_months']??0)>=6 && ($data['employment_verified_demo']??false), 'Faltan tres liquidaciones de los períodos anteriores al reposo, cotizaciones de seis meses o vínculo laboral de demo.');
                    }
                    $this->check($status === 'empleador', 'El expediente no está en el empleador.');
                    $this->check(count($data['documents']) === count(self::DOCS), 'Incorpora todos los antecedentes antes de enviar.');
                    $monthly = (int) ($input['monthly_net'] ?? 0);
                    $this->check($monthly >= 100000 && $monthly <= 10000000, 'Ingresa un promedio mensual neto entre $100.000 y $10.000.000.');
                    $data['monthly_net'] = $monthly; $data['documents_digest']=RiskControlService::digest($data); $status = 'revision';
                    $label = 'Empleador remite antecedentes a '.($data['insurance'] === 'Fonasa' ? 'COMPIN' : 'Isapre').' simulada';
                    break;
                case 'dictamen':
                    $this->check($status === 'revision', 'El expediente no está pendiente de dictamen.');
                    $this->check(!$data['hold'], 'Resuelve la alerta en Auditoría antes del dictamen.');
                    $decision = $input['decision'] ?? '';
                    $this->check(in_array($decision, ['aprobada','reducida','rechazada']), 'Dictamen no válido.');
                    $this->check(strlen($note) >= 10, 'Fundamenta el dictamen con al menos 10 caracteres.');
                    $approved = $decision === 'aprobada' ? $data['days'] : ($decision === 'rechazada' ? 0 : (int) ($input['approved_days'] ?? 0));
                    $this->check($decision !== 'reducida' || ($approved > 0 && $approved < $data['days']), 'Los días reducidos deben ser mayores a cero y menores a los solicitados.');
                    if(config('demo.automatic_review',true)){$evaluation=app(AutoReviewService::class)->evaluate($case);$data['manual_review_signature']=hash('sha256',json_encode([$evaluation['parameters'],$evaluation['reasons'],$evaluation['checks']??[]]));}
                    $data['decision_history'][]=['decision'=>$decision,'note'=>$note,'operator'=>$actor,'at'=>now()->toIso8601String()];
                    $data['approved_days'] = $approved; $data['resolution'] = $note; $status = $decision;
                    $label = 'Dictamen simulado: '.self::STATES[$decision];
                    break;
                case 'apelar':
                    $this->check(in_array($status, ['reducida','rechazada']), 'Solo se reclama una reducción o rechazo sin pago.');
                    $this->check($data['appeal_level'] < count($this->appealSteps($data)), 'El recorrido de reclamación del demo ya finalizó.');
                    $this->check(strlen($note) >= 10, 'Escribe los fundamentos de la reclamación.');
                    $data['prior_status'] = $status; $data['appeal_reason'] = $note;
                    $data['appeal_entity'] = $this->appealSteps($data)[$data['appeal_level']];
                    $status = 'apelacion'; $label = 'Reclamación simulada presentada: '.$data['appeal_entity'];
                    break;
                case 'resolver':
                    $this->check($status === 'apelacion', 'No hay reclamación pendiente.');
                    $this->check(!$data['hold'], 'Resuelve primero la alerta de auditoría.');
                    $this->check(strlen($note) >= 10, 'Fundamenta la resolución de la reclamación.');
                    $this->check(in_array($input['decision'] ?? '', ['acoger','mantener']), 'Respuesta de reclamación no válida.');
                    $status = $input['decision'] === 'acoger' ? 'aprobada' : $data['prior_status'];
                    if ($status === 'aprobada') { $data['approved_days'] = $data['days']; }
                    $data['appeal_level']++; $data['resolution'] = $note;
                    $label = $data['appeal_entity'].' simulada: '.($input['decision'] === 'acoger' ? 'reclamación acogida' : 'dictamen mantenido');
                    break;
                case 'pagar':
                    if(config('demo.automatic_review',true)){
                        $evaluation=app(AutoReviewService::class)->evaluate($case);
                        $this->check(!collect($evaluation['checks']??[])->contains('severity','bloqueo'),'Hay un bloqueo técnico confirmado que no admite excepción de pago.');
                        $signature=hash('sha256',json_encode([$evaluation['parameters'],$evaluation['reasons'],$evaluation['checks']??[]]));
                        $this->check(!$evaluation['requires_review'] || ($data['manual_review_signature']??null)===$signature,'El caso incumple parámetros de Contraloría o tiene datos faltantes; requiere revisión humana antes del pago.');
                    }
                    $this->check($data['consent'] && count($data['documents'])===count(self::DOCS), 'El pago requiere aprobación del paciente y antecedentes completos.');
                    $this->check(in_array($status, ['aprobada','reducida']), 'Solo se pagan licencias con resolución favorable y sin pago previo.');
                    $this->check(!$data['hold'], 'La alerta de auditoría impide el pago hasta su revisión.');
                    if(config('demo.risk_checks',true) && !empty($riskSettings['risk_rules']['payment']))app(RiskControlService::class)->claimPayment($case);
                    $data['payment'] = $this->subsidy($data) + ['receipt'=>'SIL-DEMO-'.Str::upper(Str::random(8)), 'at'=>now()->toIso8601String()];
                    $status = 'pagada'; $label = 'Pago simulado registrado; comprobante disponible';
                    break;
                case 'alerta':
                    $this->check(!in_array($status, ['pagada','cancelada']), 'El caso está cerrado.');
                    $this->check(!$data['hold'], 'Ya existe una revisión preventiva abierta.');
                    $this->check(strlen($note) >= 10, 'Describe la señal que requiere revisión.');
                    $data['hold'] = true; $data['alerts'][] = ['detail'=>$note,'at'=>now()->toIso8601String()];
                    $label = 'Alerta de ejemplo: revisión humana requerida';
                    break;
                case 'liberar':
                    $this->check($data['hold'], 'No existe una alerta pendiente.');
                    $this->check(strlen($note) >= 10, 'Registra el fundamento de la revisión humana.');
                    $data['hold'] = false; $label = 'Auditoría cierra la alerta con revisión humana';
                    break;
            }
            if(in_array($action,['emitir','dictamen','pagar']))$data['workflow_actors'][$action]=$actor;
            if($action==='dictamen' && config('demo.automatic_review',true)){$case->data=$data;$evaluation=app(AutoReviewService::class)->evaluate($case);$data['manual_review_signature']=hash('sha256',json_encode([$evaluation['parameters'],$evaluation['reasons'],$evaluation['checks']??[]]));}
            $this->event($data, $role, $label, $note);
            $data['events'][array_key_last($data['events'])]['operator']=$actor;
            $last = array_key_last($data['events']);
            $data['events'][$last]['source'] = ($input['channel'] ?? '') === 'app' ? 'App de control' : 'Portal web';
            $case->update(['status'=>$status,'data'=>$data,'version'=>$case->version + 1]);
            return $case->fresh();
        });
    }

    public function subsidy(array $data, bool $proposal = false): array
    {
        $days = (int) ($data['approved_days'] ?? $data['days']);
        $waiting = !$proposal && $days <= 10 ? min(3, $days) : 0;
        $paid = max(0, $days - $waiting);
        return ['days'=>$days, 'waiting'=>$waiting, 'paid_days'=>$paid, 'daily'=>round($data['monthly_net'] / 30, 2), 'amount'=>(int) round($data['monthly_net'] / 30 * $paid)];
    }

    public function appealSteps(array $data): array
    {
        return $data['insurance'] === 'Isapre' ? ['Reclamo ante COMPIN','Reposición ante COMPIN','Reclamación ante SUSESO'] : ['Reposición ante COMPIN','Reclamación ante SUSESO'];
    }

    public function sample(string $scenario): DemoLicenciaCase
    {
        return DB::transaction(fn () => $this->buildSample($scenario));
    }
    private function buildSample(string $scenario): DemoLicenciaCase
    {
        $case = $this->create(['scenario'=>$scenario, 'days'=>$scenario === 'corta' ? 7 : 14, 'insurance'=>$scenario === 'rechazo' ? 'Isapre' : 'Fonasa']);
        if ($scenario === 'nuevo' || $scenario === 'corta') { return $case; }
        foreach (['bono','profesional','identidad','emitir'] as $action) { $case = $this->act($case, $action, 'profesional', [], $case->version); }
        $case = $this->act($case, 'autorizar', 'paciente', [], $case->version);
        if ($scenario === 'empleador') { return $case; }
        foreach (array_keys(self::DOCS) as $doc) { $case = $this->act($case, 'documento', 'empleador', ['document'=>$doc], $case->version); }
        $case = $this->act($case, 'enviar', 'empleador', ['monthly_net'=>900000], $case->version);
        if ($scenario === 'rechazo') { $case = $this->act($case, 'dictamen', 'contraloria', ['decision'=>'rechazada','note'=>'Caso ficticio: se requiere ampliar el informe clínico.'], $case->version); }
        return $case;
    }

    private function check(bool $condition, string $message): void
    {
        if (!$condition) { throw ValidationException::withMessages(['workflow'=>$message]); }
    }
    private function event(array &$data, string $role, string $label, string $note = ''): void
    {
        $data['events'][] = ['at'=>now()->timezone('America/Santiago')->format('d-m-Y H:i:s'),'role'=>self::ROLES[$role] ?? $role,'label'=>$label,'note'=>$note];
    }
}
