FROM nystudio107/php-prod-base:8.0-alpine

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
        su-exec \
        gifsicle \
        jpegoptim \
        libwebp-tools \
        nano \
        optipng \
        postgresql-client \
        postgresql-dev \
    && \
    # Install PHP extensions
    docker-php-ext-install \
        pdo_pgsql \
        pgsql \
    && \
    # Install Composer
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer \
    && \
    # Remove the build deps
    apk del .build-deps \
    && \
    # Clean out directories that don't need to be part of the image
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/project

COPY ./run_queue.sh .
RUN chmod a+x run_queue.sh \
    && \
    mkdir -p /var/www/project/cms/storage \
    && \
    mkdir -p /var/www/project/cms/web/cpresources \
    && \
    chown -R www-data:www-data /var/www/project

WORKDIR /var/www/project/cms

# Force permissions, update Craft, and start php-fpm

# Do a `composer install` without running any Composer scripts
# - If `composer.lock` is present, it will install what is in the lock file
# - If `composer.lock` is missing, it will update to the latest dependencies
#   and create the `composer.lock` file
# This automatic running adds to the startup overhead of `docker-compose up`
# but saves far more time in not having to deal with out of sync versions
# when working with teams or multiple environments
CMD chown -R www-data:www-data /var/www/project \
    && \
    su-exec www-data composer install --verbose --no-progress --no-scripts --optimize-autoloader --no-interaction \
    && \
    su-exec www-data composer craft-update \
    && \
    php-fpm
