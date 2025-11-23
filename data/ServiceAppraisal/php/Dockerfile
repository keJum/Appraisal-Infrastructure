FROM php:8.4-fpm-alpine

# Устанавливаем composer и проверяем его доступность
RUN apk add --no-cache --update curl git unzip \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && chmod +x /usr/local/bin/composer \
    && composer --version

WORKDIR /var/www/html

# Устанавливаем системные зависимости
RUN apk add --no-cache \
        libpng-dev \
        libjpeg-turbo-dev \
        libwebp-dev \
        libxpm-dev \
        oniguruma-dev \
        freetype-dev \
        zip \
        unzip \
        curl \
        git \
        bash

# Устанавливаем PHP‑расширения, которые часто нужны
RUN docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
        --with-webp \
        && docker-php-ext-install -j$(nproc) gd \
        && docker-php-ext-install -j$(nproc) pdo pdo_mysql mysqli

# Устанавливаем Xdebug (если нужен)
RUN #pecl install xdebug && docker-php-ext-enable xdebug


# Финальная проверка что composer доступен
RUN composer --version