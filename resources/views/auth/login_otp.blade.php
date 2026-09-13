@extends('layouts.admin')

@section('content')

<div class="container mt-5" style="max-width: 500px;">

    <h3>Validación de seguridad</h3>

    <p>
        Ingresa el código OTP enviado para completar el acceso.
    </p>

    @if(session('otp_demo'))
        <div class="alert alert-warning">
            OTP DEMO: <strong>{{ session('otp_demo') }}</strong>
        </div>
    @endif

    @if($errors->any())
        <div class="alert alert-danger">
            {{ $errors->first() }}
        </div>
    @endif

    <form method="POST" action="{{ route('login.otp.validar') }}">
        @csrf

        <div class="mb-3">
            <label>Código OTP</label>
            <input type="text"
                   name="otp"
                   class="form-control"
                   maxlength="6"
                   required>
        </div>

        <button class="btn btn-primary">
            Validar acceso
        </button>
    </form>

</div>

@endsection
