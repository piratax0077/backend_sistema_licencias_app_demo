<?php

namespace App\Console\Commands;

use App\Models\User;
use App\Support\Rut;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class CreatePatientAppUser extends Command
{
    protected $signature = 'patient-app:user
        {email : Correo de acceso}
        {rut : RUT asociado a las licencias}
        {--name= : Nombre visible}
        {--password= : Contraseña; si se omite se solicita sin mostrarla}';

    protected $description = 'Crea o actualiza una cuenta paciente local para la app de licencias';

    public function handle(): int
    {
        $email = mb_strtolower(trim((string) $this->argument('email')));
        $rut = Rut::clean((string) $this->argument('rut'));
        $password = (string) ($this->option('password') ?: $this->secret('Contraseña'));
        $name = trim((string) ($this->option('name') ?: 'Paciente '.$rut));

        $validator = Validator::make(compact('email', 'rut', 'password', 'name'), [
            'email' => ['required', 'email', 'max:255'],
            'rut' => ['required', 'string', 'min:2', 'max:20'],
            'password' => ['required', 'string', 'min:8', 'max:255'],
            'name' => ['required', 'string', 'max:255'],
        ]);

        if ($validator->fails()) {
            foreach ($validator->errors()->all() as $error) {
                $this->error($error);
            }
            return self::FAILURE;
        }

        $user = User::updateOrCreate(
            ['email' => $email],
            ['name' => $name, 'rut' => Rut::format($rut), 'password' => Hash::make($password), 'rol' => 'paciente', 'activo' => true]
        );
        $user->tokens()->delete();

        $this->info('Cuenta paciente lista: '.$user->email.' · RUT '.$user->rut);
        return self::SUCCESS;
    }
}
