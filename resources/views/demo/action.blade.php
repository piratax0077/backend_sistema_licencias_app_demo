<form method="POST" action="{{ route('demo.action',$case) }}" class="action-form">
@csrf<input type="hidden" name="version" value="{{ $case->version }}"><input type="hidden" name="action" value="{{ $action }}">
@foreach(($fields ?? []) as $key=>$value)<input type="hidden" name="{{ $key }}" value="{{ $value }}">@endforeach
<button class="button {{ $style ?? '' }}">{{ $label }}</button></form>
