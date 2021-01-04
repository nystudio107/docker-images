FROM nystudio107/php-dev-base:7.4-alpine

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

# Create the storage directory and make it writeable by PHP
RUN mkdir -p /var/www/project/cms/storage && \
    mkdir -p /var/www/project/cms/storage/runtime && \
    chown -R www-data:www-data /var/www/project/cms/storage

# Create the cpresources directory and make it writeable by PHP
RUN mkdir -p /var/www/project/cms/web/cpresources && \
    chown -R www-data:www-data /var/www/project/cms/web/cpresources

WORKDIR /var/www/project/cms