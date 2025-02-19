FROM nystudio107/php-prod-base:8.3-alpine

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
    # pecl PHP extensions
    pecl install \
        xdebug \
    && \
    # Enable PHP extensions
    docker-php-ext-enable \
        xdebug \
    && \
    # Remove the build deps
    apk del .build-deps \
    && \
    # Clean out directories that don't need to be part of the image
    rm -rf /tmp/* /var/tmp/*

# Copy the `xdebug.ini` file into place for xdebug
COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Copy the `zzz-docker-php.ini` file into place for php
COPY zzz-docker-php.ini /usr/local/etc/php/conf.d/

# Copy the `zzz-docker-php-fpm.conf` file into place for php-fpm
COPY zzz-docker-php-fpm.conf /usr/local/etc/php-fpm.d/
