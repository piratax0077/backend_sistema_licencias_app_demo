#!/bin/sh
set -eu

mkdir -p storage/framework/cache/data storage/framework/sessions storage/framework/views storage/logs bootstrap/cache

if [ ! -f vendor/autoload.php ]; then
    composer install --no-interaction --prefer-dist
fi

if [ ! -f .env ]; then
    cp .env.example .env
fi

if ! grep -Eq '^APP_KEY=base64:.+' .env; then
    php artisan key:generate --force
fi

php artisan optimize:clear

exec "$@"
