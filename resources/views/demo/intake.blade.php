@extends('demo.layout')
@section('content')
<style>.steps>div{min-width:0}.steps b{overflow-wrap:anywhere}.panel input,.panel select,.panel textarea{max-width:100%;box-sizing:border-box}@media(max-width:600px){.steps{grid-template-columns:repeat(2,minmax(0,1fr))!important}.steps>div{padding:12px!important}}</style>
<link rel="stylesheet" href="{{ asset('demo-assets/vista1.css') }}"><link rel="stylesheet" href="{{ asset('demo-assets/preview.css') }}">
<h1 class="sr-only" style="position:absolute;width:1px;height:1px;overflow:hidden;clip-path:inset(50%)">Del paciente a la decisión clínica</h1>
<section class="steps intake-steps" aria-label="Flujo de atención">@foreach(['Paciente','Profesional','Lugar de atención','Consulta','¿Indica reposo?','Primer filtro'] as $step)<div><span>{{ $loop->iteration }}</span><b>{{ $step }}</b></div>@endforeach</section>
<p class="relation-key"><span></span> Paciente, profesional, lugar y consulta forman una misma relación de atención.</p><section class="notice intake-controls" aria-label="Ocho controles del primer filtro">
<ol><li>Existe hora tomada <em>(relación paciente-profesional)</em></li><li>Existe un QR o bono de atención verificado</li><li>Cuántos minutos tomó la consulta</li><li>Cuántos pacientes atendió el profesional <em>(relación licencias por consulta)</em></li></ol>
<ol start="5"><li>N.º de licencias mensuales del profesional</li><li>N.º de licencias del paciente con el mismo profesional <em>(relación licencias del paciente)</em></li><li>Tipo de consulta presencial o telemática <em>(concordar modo)</em></li><li>Profesional habilitado en Chile para emitir licencias médicas <em>(verificación simulada)</em></li></ol>
</section>
<div class="intake-cards">
@foreach(['patients'=>['Pacientes','patient_id'],'professionals'=>['Profesionales','professional_id'],'sites'=>['Lugares de atención','site_id']] as $type=>$labels)
<section class="panel"><h2>{{ $labels[0] }}</h2>
@if($type==='sites')
<label>Seleccionar lugares de atención<select name="site_id" form="consultation-form" required data-relation="sites"><option value="">Seleccionar…</option>@foreach($lists[$type] as $record)<option value="{{ $record->id }}" @selected(old('site_id',$editing?->site_id)==$record->id)>{{ $record->name }} · {{ $record->detail }}{{ $record->source==='medsdi'?' · Med-SDI':'' }}</option>@endforeach</select></label>
@else
<label>Buscar {{ $type==='patients'?'paciente':'profesional' }} por RUT<input id="{{ $type }}-rut-search" type="text" inputmode="text" autocomplete="off" placeholder="Ej.: 12.345.678-5"></label>
<button id="{{ $type }}-rut-button" type="button" class="button small">Buscar por RUT</button>
<p id="{{ $type }}-rut-result" class="fine" role="status">Ingresa un RUT para consultar directamente en Med-SDI.</p>
<select name="{{ $labels[1] }}" form="consultation-form" required data-relation="{{ $type }}" hidden><option value="">Seleccionar…</option>@foreach($lists[$type] as $record)<option value="{{ $record->id }}" @selected(old($labels[1],$editing?->{$labels[1]})==$record->id)>{{ $record->name }} · {{ $record->detail }}{{ $record->source==='medsdi'?' · Med-SDI':'' }}</option>@endforeach</select>
@endif
<p class="fine">Consulta en línea al backend de Med-SDI. Los datos se administran en el sistema de origen.</p>
</section>@endforeach
<section class="panel intake-relation" aria-live="polite"><h2>Relación de la atención</h2><label style="flex:1;min-width:220px">Relaciones registradas del paciente<select id="saved-relation"><option value="">Selecciona un paciente</option></select></label><p id="selected-relation">Selecciona paciente, profesional y lugar de atención.</p><form id="relation-form" method="POST" action="{{ url('/demo/relaciones') }}">@csrf<input id="relation-patient" type="hidden" name="patient_id"><input id="relation-professional" type="hidden" name="professional_id"><input id="relation-site" type="hidden" name="site_id"><button id="save-relation" type="submit" class="button" disabled>Guardar relación</button></form><p class="fine">Guarda esta relación para continuar desde el perfil Paciente sin registrar todavía una atención.</p></section>
</div>
<section class="panel" id="atencion">
<div class="section-head"><div><div class="eyebrow">VISTA DE LICENCIA · EJEMPLO</div><h2>Licencia emitida por <span id="preview-days">{{ $editing?->days ?: 7 }}</span> días</h2></div><span class="badge">Emisión ilustrativa · demo</span></div>
<div class="license-preview-grid">
<article class="license-preview-document">
<div class="section-head"><strong>Licencia médica de reposo</strong><span>LME-DEMO · Vista previa</span></div>
<dl class="license-preview-fields">
<div><dt>Paciente</dt><dd id="preview-patient">Paciente por seleccionar</dd></div>
<div><dt>Profesional</dt><dd id="preview-professional">Profesional por seleccionar</dd></div>
<div><dt>Lugar de consulta</dt><dd id="preview-site">Lugar por seleccionar</dd></div>
<div><dt>Período de reposo</dt><dd>{{ $editing?->start ?: now()->toDateString() }} · {{ $editing?->days ?: 7 }} días</dd></div>
<div class="full"><dt>Lugar de reposo</dt><dd>{{ $editing?->address ?: 'Domicilio del paciente · dirección de ejemplo' }}</dd></div>
</dl>
<fieldset class="preview-options"><legend>Tipo de reposo</legend><label><input type="radio" name="preview-rest" value="total" checked> Total</label><label><input type="radio" name="preview-rest" value="parcial"> Parcial</label></fieldset>
<div class="clinical"><strong>Diagnóstico</strong><p>{{ $editing?->diagnosis ?: 'Cuadro clínico ficticio para demostración' }}</p><fieldset class="preview-options"><legend>Estado del diagnóstico</legend><label><input type="radio" name="preview-diagnosis" value="confirmado" checked> Confirmado</label><label><input type="radio" name="preview-diagnosis" value="en_estudio"> En estudio</label></fieldset></div>
<p class="fine">Representación de una licencia para presentar el demo. No registra ni emite una licencia real. Las opciones de esta vista son ilustrativas.</p>
</article>
<aside class="license-preview-bono"><div class="eyebrow">BONO DE ATENCIÓN</div><h3>{{ $editing?->bono ?: 'BONO-DEMO-001' }}</h3><p>Atención asociada al paciente, profesional y lugar seleccionados.</p><canvas id="attention-preview-qr" aria-label="QR del bono de atención de ejemplo"></canvas><span class="badge">QR de demostración</span><p class="fine">El QR contiene la referencia del bono de ejemplo; no acredita una validación oficial.</p></aside>
</div>
<details class="license-edit-details"><summary>Editar datos de la atención y ejecutar el flujo (opcional)</summary><p>Para presentar esta vista no es necesario llenar el formulario. Para registrar una atención y evaluar sus controles, completa los datos siguientes.</p>
<form id="consultation-form" method="POST" action="{{ url('/demo/atenciones') }}">@csrf<input type="hidden" name="id" value="{{ old('id',$editing?->id) }}">
<div style="display:grid;grid-template-columns:repeat(auto-fit,minmax(min(100%,240px),1fr));gap:16px">
@foreach(['appointment_at'=>'Hora tomada (opcional)','started_at'=>'Inicio de consulta','ended_at'=>'Fin de consulta'] as $field=>$label)<label>{{ $label }}<input type="datetime-local" name="{{ $field }}" value="{{ old($field,$editing?->$field ? \Carbon\Carbon::parse($editing->$field)->format('Y-m-d\TH:i') : '') }}" @required($field!=='appointment_at')></label>@endforeach
@foreach(['appointment_mode'=>'Modalidad de la hora tomada','mode'=>'Modalidad de la consulta'] as $field=>$label)<label>{{ $label }}<select name="{{ $field }}" @required($field==='mode')><option value="">Seleccionar…</option>@foreach(['presencial'=>'Presencial','telematica'=>'Telemática'] as $value=>$text)<option value="{{ $value }}" @selected(old($field,$editing?->$field)===$value)>{{ $text }}</option>@endforeach</select></label>@endforeach
<label class="checkbox"><input type="checkbox" name="professional_enabled" value="1" @checked(old('professional_enabled',$editing?->professional_enabled))> Confirmo en el demo que el profesional está habilitado en Chile para emitir licencias médicas. Verificación simulada, sin consulta a un registro oficial.</label><label>QR o número de bono<input name="bono" value="{{ old('bono',$editing?->bono) }}"></label><label><input type="checkbox" name="bono_verified" value="1" @checked(old('bono_verified',$editing?->bono_verified))> QR o bono verificado en el demo</label>
<label>Decisión del profesional<select name="decision" required><option value="sin_licencia" @selected(old('decision',$editing?->decision)==='sin_licencia')>Sin licencia de reposo</option><option value="con_licencia" @selected(old('decision',$editing?->decision)==='con_licencia')>Preparar licencia y primer filtro</option></select></label>
<label>Previsión<select name="insurance">@foreach(['Fonasa','Isapre'] as $value)<option @selected(old('insurance',$editing?->insurance)===$value)>{{ $value }}</option>@endforeach</select></label>
<label>Domicilio de reposo / paciente<input name="address" required value="{{ old('address',$editing?->address) }}"></label><label>Días de reposo (si corresponde)<input name="days" type="number" min="1" max="60" value="{{ old('days',$editing?->days) }}"></label><label>Inicio de reposo (si corresponde)<input type="date" name="start" value="{{ old('start',$editing?->start) }}"></label>
</div><label>Motivo de atención / diagnóstico ficticio<textarea name="diagnosis" required maxlength="500">{{ old('diagnosis',$editing?->diagnosis) }}</textarea></label><button>Guardar atención y decisión</button>@if($editing)<a class="button secondary" href="/">Cancelar edición</a>@endif</form></details></section>
<section class="panel"><h2>Atenciones registradas ({{ $consultations->count() }})</h2><div class="tablebox attention-table"><table><thead><tr><th>Paciente / profesional / lugar</th><th>Tipo de atención</th><th>N.º mismo paciente</th><th>Duración</th><th>Licencias al mismo paciente</th><th>Bono asociado a consulta</th><th>Objeciones Contraloría</th><th>Acciones</th></tr></thead><tbody>
@forelse($consultations as $c)
@php
$related=$consultations->where('patient_id',$c->patient_id)->where('professional_id',$c->professional_id);
$issued=$related->filter(fn($row)=>$row->case_id && ($cases->firstWhere('id',$row->case_id)?->status ?? 'borrador')!=='borrador')->count();
$objections=$c->case_id?$audits->where('case_id',$c->case_id)->where('passed',false):collect();
@endphp
<tr><td>{{ $lists['patients']->firstWhere('id',$c->patient_id)?->name }}<br>{{ $lists['professionals']->firstWhere('id',$c->professional_id)?->name }}<br>{{ $lists['sites']->firstWhere('id',$c->site_id)?->name }}<small>{{ $c->started_at }}</small></td><td>{{ $c->mode==='telematica'?'Telemática':'Presencial' }}<small>{{ $c->decision==='sin_licencia'?'Sin licencia':'Con reposo' }}</small></td><td>{{ $related->count() }}</td><td>{{ (int)\Carbon\Carbon::parse($c->started_at)->diffInMinutes(\Carbon\Carbon::parse($c->ended_at)) }} min</td><td>{{ $issued }}</td><td>{{ $c->bono ?: 'Sin bono' }}<small>{{ $c->bono_verified?'Verificado · demo':'Sin verificar' }}</small></td><td>@if(in_array($role,['admin','contraloria','auditor'])){{ $objections->count() }} evaluaciones observadas<small>{{ $objections->whereNull('reviewed_at')->count() }} pendientes de revisión</small>@else Consultar con Contraloría @endif</td><td><div class="attention-actions"><a class="button small secondary" data-report-view href="{{ url('/demo/atenciones/'.$c->id.'/informe') }}">◉ Ver</a><a class="button small" data-report-send href="{{ url('/demo/atenciones/'.$c->id.'/informe') }}">↗ Enviar informe</a></div>@if(in_array($role,['admin','profesional']))<details><summary>Editar / borrar</summary><a href="{{ url('/?edit='.$c->id).'#atencion' }}">Editar atención</a><form method="POST" action="{{ url('/demo/atenciones/'.$c->id) }}" onsubmit="return confirm('¿Borrar el recorrido de demo? La auditoría se conserva.')">@csrf @method('DELETE')<button class="button small secondary">Borrar recorrido</button></form></details>@endif</td></tr>
@empty<tr><td colspan="7">Sin atenciones. Agrega un paciente, un profesional y un lugar para comenzar.</td><td><div class="attention-actions"><button class="button small secondary" disabled>◉ Ver</button><button class="button small" disabled>↗ Enviar informe</button></div><small>Disponible al registrar una atención.</small></td></tr>@endforelse
</tbody></table></div><p class="fine">N.º mismo paciente y licencias: historial registrado de ese paciente con el mismo profesional. Solo se cuentan licencias emitidas; las objeciones corresponden a evaluaciones no superadas del filtro.</p></section>
<div class="attention-bottom">
<section class="panel"><h2>Licencias emitidas ({{ $cases->where('status','!=','borrador')->count() }})</h2>@forelse($cases->where('status','!=','borrador') as $case)<p><a href="{{ route('demo.show',$case) }}">{{ $case->folio }} · {{ $case->data['patient'] }}</a> · {{ \App\Services\DemoLicenciaService::STATES[$case->status] }}</p>@empty<p>No se han creado licencias.</p>@endforelse</section>
<section class="panel report-reader" id="report-reader"><div class="section-head"><h2>Lectura del informe</h2><span class="badge">Vista de demostración</span></div><p id="report-status" role="status">Selecciona Ver en una atención para leer su informe aquí.</p><iframe id="report-frame" title="Informe de la atención seleccionada" hidden></iframe><p class="fine">Enviar informe prepara una vista de envío simulado. No se remite a destinatarios externos.</p></section>
</div>
@if(in_array($role,['admin','contraloria','auditor']))
<section class="panel" id="auditoria"><h2>Contraloría · auditoría del primer filtro</h2><p>Cada evaluación conserva su resultado, incluso si después se corrige o borra el recorrido. Los avisos pendientes requieren revisión; marcarlos revisados no autoriza una emisión que incumple el filtro.</p>
@forelse($audits as $audit)<details><summary>{{ $audit->passed?'✓ Superado':'⚠ No superado' }} · {{ $audit->folio }} · {{ $audit->patient }} · {{ $audit->reviewed_at?'Revisado':'Aviso pendiente' }}</summary><p>{{ $audit->created_at }} UTC</p><ul>@foreach(json_decode($audit->reasons,true) as $reason)<li>{{ $reason }}</li>@endforeach</ul><dl>@foreach(json_decode($audit->snapshot,true) as $label=>$value)<dt>{{ $label }}</dt><dd>{{ $value }}</dd>@endforeach</dl>@if($audit->patient_notification)<p><strong>Notificación en la app del paciente:</strong> {{ $audit->patient_notification }}</p>@endif
@if($audit->case_id)<a class="button small" href="{{ route('demo.show',$audit->case_id) }}">Abrir expediente</a>@else<p>El recorrido fue eliminado; este registro de auditoría se conserva.</p>@endif
@if($audit->reviewed_at)<p>Revisado: {{ $audit->reviewed_at }} UTC · {{ $audit->review_note }}</p>@elseif(in_array($role,['contraloria','auditor']))<form method="POST" action="{{ url('/demo/auditoria/'.$audit->id.'/revisar') }}">@csrf<label>Observación de revisión<textarea name="note" required maxlength="1000"></textarea></label><button>Registrar revisión del aviso</button></form>@endif</details>@empty<p>No hay evaluaciones registradas.</p>@endforelse</section>
@endif
@endsection
@section('scripts')
<script src="{{ asset('demo-assets/qrious.min.js') }}"></script>
<script>
document.querySelectorAll('[data-report-view],[data-report-send]').forEach(link=>link.addEventListener('click',event=>{event.preventDefault();const frame=document.getElementById('report-frame');frame.src=link.href;frame.hidden=false;document.getElementById('report-status').textContent=link.hasAttribute('data-report-send')?'Informe preparado para envío · simulación.':'Informe de la atención seleccionada';document.getElementById('report-reader').scrollIntoView({behavior:'smooth',block:'start'});}));
const relationSelects = [...document.querySelectorAll('[data-relation]')];
const savedRelations = {{ \Illuminate\Support\Js::from($relations) }};
const professionalSites = {{ \Illuminate\Support\Js::from($professionalSites) }};
const [patientSelect,professionalSelect,siteSelect] = relationSelects;
const savedSelect = document.getElementById('saved-relation');
const professionalRutInput=document.getElementById('professionals-rut-search');
const professionalRutButton=document.getElementById('professionals-rut-button');
function filterSites(clearInvalid=true){
 const allowed=(professionalSites[professionalSelect.value]||[]).map(String);
 [...siteSelect.options].forEach(option=>{if(!option.value)return;const visible=!allowed.length||allowed.includes(option.value);option.hidden=!visible;option.disabled=!visible;});
 if(clearInvalid&&siteSelect.value&&siteSelect.selectedOptions[0]?.disabled)siteSelect.value='';
 siteSelect.disabled=!professionalSelect.value;
 siteSelect.options[0].textContent=professionalSelect.value?(allowed.length?'Seleccionar lugar del profesional…':'Seleccionar lugar…'):'Selecciona primero un profesional';
}
function updateRelation(){
 document.getElementById('selected-relation').textContent = relationSelects.map((select,index)=>select.value?select.selectedOptions[0].textContent:['Paciente pendiente','Profesional pendiente','Lugar pendiente'][index]).join(' · ');
 ['patient','professional','site'].forEach((type,index)=>document.getElementById('relation-'+type).value=relationSelects[index].value);
 document.getElementById('save-relation').disabled=!relationSelects.every(select=>select.value);
}
function nameFor(select,id){return [...select.options].find(o=>o.value===String(id))?.textContent||'Registro no disponible';}
function applySaved(){const row=savedRelations[Number(savedSelect.value)];if(savedSelect.value!==''&&row){professionalSelect.value=String(row.professional_id);filterSites(false);siteSelect.value=String(row.site_id);}updateRelation();}
function loadRelations(autoSelect){
 savedSelect.replaceChildren(new Option('Nueva relación / selección manual',''));
 savedRelations.forEach((row,index)=>{if(String(row.patient_id)===patientSelect.value)savedSelect.add(new Option(nameFor(professionalSelect,row.professional_id)+' · '+nameFor(siteSelect,row.site_id),String(index)));});
 if(autoSelect){professionalSelect.value='';siteSelect.value='';if(savedSelect.options.length===2){savedSelect.selectedIndex=1;applySaved();}}
 else {const match=[...savedSelect.options].find(o=>o.value!==''&&String(savedRelations[Number(o.value)].professional_id)===professionalSelect.value&&String(savedRelations[Number(o.value)].site_id)===siteSelect.value);if(match)savedSelect.value=match.value;}
 updateRelation();
}
function toggleProfessionalSearch(){const disabled=!patientSelect.value;professionalSelect.disabled=disabled;professionalRutInput.disabled=disabled;professionalRutButton.disabled=disabled;}
patientSelect.addEventListener('change',()=>{toggleProfessionalSearch();loadRelations(true);filterSites();});
savedSelect.addEventListener('change',applySaved);
professionalSelect.addEventListener('change',()=>{filterSites();savedSelect.value='';updateRelation();});
siteSelect.addEventListener('change',()=>{savedSelect.value='';updateRelation();});
toggleProfessionalSearch();
filterSites(false);
async function searchByRut(type){
 const input=document.getElementById(type+'-rut-search');const result=document.getElementById(type+'-rut-result');const select=type==='patients'?patientSelect:professionalSelect;
 const rut=input.value.trim();if(!rut){result.textContent='Ingresa un RUT para realizar la búsqueda.';return;}
 result.textContent='Buscando en Med-SDI…';
 try{
  const response=await fetch('/api/demo/catalog/'+type+'/rut/'+encodeURIComponent(rut),{headers:{Accept:'application/json'}});const payload=await response.json().catch(()=>({}));
  if(!response.ok)throw new Error(payload.message||'No se encontró el RUT.');
  const label=payload.data.name+' · '+payload.data.detail+' · Med-SDI';
  let option=[...select.options].find(item=>item.value===String(payload.data.id));
  if(!option){option=new Option(label,String(payload.data.id));select.add(option);}else option.textContent=label;
  if(type==='professionals'){
   professionalSites[payload.data.id]=payload.data.sites.map(site=>String(site.id));
   payload.data.sites.forEach(site=>{const siteLabel=site.name+' · '+site.detail+' · Med-SDI';let siteOption=[...siteSelect.options].find(item=>item.value===String(site.id));if(!siteOption){siteOption=new Option(siteLabel,String(site.id));siteSelect.add(siteOption);}else siteOption.textContent=siteLabel;});
  }
  select.value=String(payload.data.id);select.dispatchEvent(new Event('change'));
  result.textContent=payload.data.name+' · '+payload.data.rut+' · '+payload.data.detail+(type==='professionals'?' · '+payload.data.sites.length+' lugar(es) de atención':'');
 }catch(error){select.value='';select.dispatchEvent(new Event('change'));result.textContent=error.message||'No fue posible realizar la búsqueda.';}
}
['patients','professionals'].forEach(type=>{document.getElementById(type+'-rut-button').addEventListener('click',()=>searchByRut(type));document.getElementById(type+'-rut-search').addEventListener('keydown',event=>{if(event.key==='Enter'){event.preventDefault();searchByRut(type);}});});
loadRelations(false);
function refreshLicensePreview(){
 ['preview-patient','preview-professional','preview-site'].forEach((id,index)=>{document.getElementById(id).textContent=relationSelects[index].value?relationSelects[index].selectedOptions[0].textContent:['Paciente por seleccionar','Profesional por seleccionar','Lugar por seleccionar'][index];});
 if(window.QRious)new QRious({element:document.getElementById('attention-preview-qr'),value:JSON.stringify({demo:true,bono:{{ \Illuminate\Support\Js::from($editing?->bono ?: 'BONO-DEMO-001') }},paciente:patientSelect.value,profesional:professionalSelect.value,lugar:siteSelect.value}),size:180,level:'M',foreground:'#173b42'});
}
relationSelects.forEach(select=>select.addEventListener('change',refreshLicensePreview));savedSelect.addEventListener('change',refreshLicensePreview);refreshLicensePreview();
</script>
@endsection
