FROM php:8.3-fpm-alpine

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

# Install packages
RUN set -eux; \
    # Packages needed only for build
    apk add --no-cache --virtual .build-deps \
        # Dependencies required for running "phpize"; the $PHPIZE_DEPS env var is inherited from the parent image
        # These get automatically installed and removed by "docker-php-ext-*" (unless they're already installed)
        $PHPIZE_DEPS \
        # Build deps
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
        libtool \
        linux-headers \
        wget \
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
        libtool \
        libxml2-dev \
        libzip-dev \
        oniguruma-dev \
        openssl-dev \
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
    install-php-extensions \
        gmagick \
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
        gmagick \
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
