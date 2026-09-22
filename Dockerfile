FROM php:8.4-cli

RUN apt-get update && apt-get install -y --no-install-recommends \
        git unzip libzip-dev libpng-dev libjpeg62-turbo-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) bcmath gd pdo_mysql zip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

COPY docker/entrypoint.sh /usr/local/bin/licencias-entrypoint
RUN chmod +x /usr/local/bin/licencias-entrypoint

EXPOSE 8024

ENTRYPOINT ["licencias-entrypoint"]
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8024"]
