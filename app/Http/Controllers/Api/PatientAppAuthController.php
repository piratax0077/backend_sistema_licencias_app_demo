<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Support\Rut;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class PatientAppAuthController extends Controller
{
    public function login(Request $request): JsonResponse
    {
        $input = $request->validate([
            'login' => ['required', 'string', 'max:255'],
            'password' => ['required', 'string', 'max:255'],
            'device_name' => ['nullable', 'string', 'max:100'],
        ]);

        $login = trim($input['login']);
        $user = str_contains($login, '@')
            ? User::whereRaw('LOWER(email) = ?', [mb_strtolower($login)])->first()
            : User::whereRaw(
                "UPPER(REPLACE(REPLACE(REPLACE(rut, '.', ''), '-', ''), ' ', '')) = ?",
                [Rut::clean($login)]
            )->first();

        if (! $user || ! Hash::check($input['password'], $user->password)) {
            throw ValidationException::withMessages([
                'login' => ['Las credenciales no son correctas.'],
            ]);
        }

        if (! $user->activo) {
            throw ValidationException::withMessages([
                'login' => ['La cuenta está inactiva.'],
            ]);
        }

        if ($user->rol !== 'paciente' || Rut::clean($user->rut) === null) {
            throw ValidationException::withMessages([
                'login' => ['Esta cuenta no está habilitada como paciente de la app.'],
            ]);
        }

        $token = $user->createToken(
            $input['device_name'] ?? 'app-paciente',
            ['patient-app']
        )->plainTextToken;

        return response()->json([
            'token' => $token,
            'token_type' => 'Bearer',
            'user' => $this->userData($user),
        ]);
    }

    public function me(Request $request): JsonResponse
    {
        return response()->json(['user' => $this->userData($request->user())]);
    }

    public function logout(Request $request): JsonResponse
    {
        $request->user()->currentAccessToken()?->delete();

        return response()->json(['message' => 'Sesión cerrada.']);
    }

    private function userData(User $user): array
    {
        return [
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'rut' => Rut::format($user->rut),
            'role' => $user->rol,
        ];
    }
}
