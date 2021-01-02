FROM nystudio107/php-prod-base:7.4-alpine

# Install packages
RUN set -eux; \
    && \
    # pecl PHP extensions
    pecl install \
        xdebug-2.9.8 \
    && \
    # Enable PHP extensions
    docker-php-ext-enable \
        xdebug \
    && \
    # Clean out directories that don't need to be part of the image
    rm -rf /tmp/* /var/tmp/*

# Copy the `xdebug.ini` file into place for xdebug
COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
