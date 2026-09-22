<?php
namespace App\Http\Controllers;

use App\Models\DemoLicenciaCase;
use App\Services\DemoLicenciaService;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class DemoLicenciaController extends Controller
{
    public function index(Request $request, DemoLicenciaService $flow)
    {
        $role = $request->session()->get('demo_role', 'admin');
        $query = DemoLicenciaCase::query();
        if ($request->filled('buscar')) { $query->where(function ($q) use ($request) { $q->where('folio', 'like', '%'.$request->input('buscar').'%')->orWhere('data->patient','like','%'.$request->input('buscar').'%'); }); }
        if (array_key_exists($request->input('estado',''), DemoLicenciaService::STATES)) { $query->where('status', $request->input('estado')); }
        $cases = $query->latest('id')->paginate(12)->withQueryString();
        $all = DemoLicenciaCase::all();
        return view('demo.index', compact('cases','all','role','flow'));
    }
    public function role(Request $request)
    {
        $data = $request->validate(['role'=>['required',Rule::in(array_keys(DemoLicenciaService::ROLES))]]);
        $request->session()->put('demo_role',$data['role']);
        return redirect('/');
    }
    public function show(Request $request, DemoLicenciaCase $case, DemoLicenciaService $flow)
    {
        $history = DemoLicenciaCase::all();
        $patientCases = $history->filter(fn($c) => $c->data['rut'] === $case->data['rut']);
        $doctorCases = $history->filter(fn($c) => $c->data['doctor'] === $case->data['doctor'] && $c->status !== 'borrador');
        return view('demo.show', ['case'=>$case,'d'=>$case->data,'flow'=>$flow,'role'=>$request->session()->get('demo_role','admin'),
            'patientDays'=>$patientCases->sum(fn($c) => $c->data['approved_days'] ?? 0),
            'doctorCount'=>$doctorCases->count(),
            'doctorMonthCount'=>$doctorCases->filter(fn($c) => $c->created_at->format('Y-m') === now()->format('Y-m'))->count(),
        ]);
    }
    public function create(Request $request, DemoLicenciaService $flow)
    {
        abort_unless(in_array($request->session()->get('demo_role','admin'),['admin','profesional']),403);
        $data = $request->validate(['patient'=>'required|string|max:100','rut'=>'required|string|max:20','address'=>'required|string|max:200','days'=>'required|integer|min:1|max:60','start'=>'required|date_format:Y-m-d','insurance'=>['required',Rule::in(['Fonasa','Isapre'])],'diagnosis'=>'required|string|max:500']);
        $case = $flow->create($data);
        $request->session()->put('demo_role','profesional');
        return redirect()->route('demo.show',$case)->with('ok','Expediente ficticio creado. Completa las verificaciones para emitir.');
    }
    public function sample(Request $request, DemoLicenciaService $flow)
    {
        abort_unless($request->session()->get('demo_role','admin') === 'admin',403);
        $data = $request->validate(['scenario'=>['required',Rule::in(['nuevo','corta','empleador','revision','rechazo'])]]);
        $case = $flow->sample($data['scenario']);
        $request->session()->put('demo_role',match($data['scenario']) {'empleador'=>'empleador','revision'=>'contraloria','rechazo'=>'paciente',default=>'profesional'});
        return redirect()->route('demo.show',$case)->with('ok','Escenario de ejemplo creado. Puedes continuar el recorrido.');
    }
    public function action(Request $request, DemoLicenciaCase $case, DemoLicenciaService $flow)
    {
        $data = $request->validate(['action'=>'required|string|max:30','version'=>'required|integer|min:1','note'=>'nullable|string|max:1000','document'=>'nullable|string|max:30','kind'=>'nullable|string|max:30','consent_control'=>'nullable|in:1','decision'=>'nullable|string|max:30','approved_days'=>'nullable|integer|min:0|max:60','monthly_net'=>'nullable|integer|min:100000|max:10000000']);
        $flow->act($case,$data['action'],$request->session()->get('demo_role','admin'),$data,(int)$data['version']);
        return redirect()->route('demo.show',$case)->with('ok','Acción registrada. El expediente y la trazabilidad están actualizados.');
    }
    public function document(DemoLicenciaCase $case, string $document)
    {
        abort_unless(isset($case->data['documents'][$document]),404);
        return response()->view('demo.document',['case'=>$case,'document'=>$document,'receipt'=>false])->header('Content-Disposition','inline; filename="'.$case->folio.'-'.$document.'.html"');
    }
    public function receipt(DemoLicenciaCase $case)
    {
        abort_unless($case->status === 'pagada',404);
        return view('demo.document',['case'=>$case,'document'=>null,'receipt'=>true]);
    }
    public function verify(string $token)
    {
        $case = DemoLicenciaCase::where('data->token',$token)->firstOrFail();
        return view('demo.verify',compact('case'));
    }
}
