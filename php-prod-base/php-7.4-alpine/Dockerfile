FROM php:7.4-fpm-alpine

# dependencies required for running "phpize"
# these get automatically installed and removed by "docker-php-ext-*" (unless they're already installed)
ENV PHPIZE_DEPS \
        autoconf \
        dpkg-dev \
        dpkg \
        file \
        g++ \
        gcc \
        libc-dev \
        make \
        pkgconf \
        re2c \
        wget

# Install packages
RUN set -eux; \
    # Packages needed only for build
    apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
    && \
    # Packages to install
    apk add --no-cache \
        bzip2-dev \
        ca-certificates \
        curl \
        fcgi \
        freetype-dev \
        gettext-dev \
        gnu-libiconv=1.15-r3 \
        icu-dev \
        imagemagick \
        imagemagick-dev \
        libjpeg-turbo-dev \
        libmcrypt-dev \
        libpng \
        libpng-dev \
        libressl-dev \
        libtool \
        libwebp-dev \
        libxml2-dev \
        libzip-dev \
        oniguruma-dev \
        unzip \
    && \
    # pecl PHP extensions
    pecl install \
        imagick-3.4.4 \
        redis \
    && \
    # Configure PHP extensions
    docker-php-ext-configure \
        # ref: https://github.com/docker-library/php/issues/920#issuecomment-562864296
        gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && \
    # Install PHP extensions
    docker-php-ext-install \
        bcmath \
        bz2 \
        exif \
        ftp \
        gettext \
        gd \
        iconv \
        intl \
        mbstring \
        opcache \
        pdo \
        shmop \
        sockets \
        sysvmsg \
        sysvsem \
        sysvshm \
        zip \
    && \
    # Enable PHP extensions
    docker-php-ext-enable \
        imagick \
        redis \
    && \
    # Remove the build deps
    apk del .build-deps \
    && \
    # Clean out directories that don't need to be part of the image
    rm -rf /tmp/* /var/tmp/*

# https://github.com/docker-library/php/issues/1121
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php

# Copy the `zzz-docker-php.ini` file into place for php
COPY zzz-docker-php.ini /usr/local/etc/php/conf.d/

# Copy the `zzz-docker-php-fpm.conf` file into place for php-fpm
COPY zzz-docker-php-fpm.conf /usr/local/etc/php-fpm.d/
