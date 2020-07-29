FROM php:7.2-fpm

# Install packages
RUN apt-get update \
    && \
    # apt Debian packages
    apt-get install -y \
        apt-utils \
        autoconf \
        ca-certificates \
        curl \
        g++ \
        git \
        libbz2-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libpq-dev \
        libssl-dev \
        libicu-dev \
        libmagickwand-dev \
        libxml2-dev \
        libzip-dev \
        rsync \
        unzip \
        zip \
        vim \
        nano \
    && \
    # Configure PHP extensions
    docker-php-ext-configure \
        gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
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
        pdo_mysql \
        shmop \
        soap \
        sockets \
        sysvmsg \
        sysvsem \
        sysvshm \
        zip

ADD https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz /tmp/

RUN tar xzfC /tmp/ioncube_loaders_lin_x86-64.tar.gz /tmp/ \
    && rm /tmp/ioncube_loaders_lin_x86-64.tar.gz \
    && mkdir -p /usr/local/ioncube \
    && cp /tmp/ioncube/ioncube_loader_* /usr/local/ioncube \
    && rm -rf /tmp/ioncube

# Append our php.ini overrides to the end of the file
RUN echo "upload_max_filesize = 10M" > /usr/local/etc/php/php.ini && \
    echo "post_max_size = 10M" >> /usr/local/etc/php/php.ini && \
    echo "max_execution_time = 300" >> /usr/local/etc/php/php.ini && \
    echo "memory_limit = 256M" >> /usr/local/etc/php/php.ini && \
    echo "opcache.revalidate_freq = 0" >> /usr/local/etc/php/php.ini && \
    echo "opcache.validate_timestamps = 1" >> /usr/local/etc/php/php.ini && \
    echo "zend_extension=/usr/local/ioncube/ioncube_loader_lin_7.2.so" >> /usr/local/etc/php/php.ini

# Copy the `zzz-docker.conf` file into place for php-fpm
COPY ./zzz-docker.conf /usr/local/etc/php-fpm.d/zzz-docker.conf
