FROM php:7.4-fpm
MAINTAINER Paolo Galeone <nessuno@nerdz.eu>

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libcurl4-openssl-dev \
        libpq-dev

RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    gd \
    curl \
    sockets \
    gettext \
    pgsql \
    pdo_pgsql
RUN pecl install apcu && \
        docker-php-ext-enable apcu
