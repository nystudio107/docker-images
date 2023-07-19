FROM php:8.2-fpm-alpine3.17

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
        zlib-dev \
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
        icu-dev \
        icu-data-full \
        imagemagick-dev \
        jpeg-dev \
        libpng-dev \
        libwebp-dev \
        libzip-dev \
        libmcrypt-dev \
        libressl-dev \
        libtool \
        libxml2-dev \
        libzip-dev \
        oniguruma-dev \
        unzip \
    && \
    # pecl PHP extensions
    pecl install \
        redis \
    && \
    # Configure PHP extensions
    docker-php-ext-configure \
        # ref: https://github.com/docker-library/php/issues/920#issuecomment-562864296
        gd --enable-gd --with-freetype --with-jpeg --with-webp \
    && \
    pecl install \
        imagick \
    && \
    # Install PHP extensions
    docker-php-ext-install -j$(nproc) \
        bcmath \
        bz2 \
        exif \
        ftp \
        gettext \
        gd \
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

# Copy the `zzz-docker-php.ini` file into place for php
COPY zzz-docker-php.ini /usr/local/etc/php/conf.d/

# Copy the `zzz-docker-php-fpm.conf` file into place for php-fpm
COPY zzz-docker-php-fpm.conf /usr/local/etc/php-fpm.d/
