FROM php:8.4-fpm

# Instala dependências e extensões PHP necessárias ao Laravel
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        unzip \
        libicu-dev \
        libzip-dev \
        libpng-dev \
        libonig-dev \
        libxml2-dev \
        default-mysql-client \
        curl \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql \
        intl \
        zip \
        opcache \
    && rm -rf /var/lib/apt/lists/*

# Composer (útil para diagnósticos/eventuais installs)
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Opcional: diretórios de cache/logs com permissões para www-data
RUN chown -R www-data:www-data /var/www/html || true
