<?php

namespace App\Support;

class Rut
{
    public static function clean(?string $rut): ?string
    {
        if ($rut === null) {
            return null;
        }

        $clean = strtoupper(preg_replace('/[^0-9K]/i', '', trim($rut)));

        return $clean === '' ? null : $clean;
    }

    public static function format(?string $rut): ?string
    {
        $clean = self::clean($rut);

        if ($clean === null || strlen($clean) < 2) {
            return $clean;
        }

        return substr($clean, 0, -1) . '-' . substr($clean, -1);
    }
}
