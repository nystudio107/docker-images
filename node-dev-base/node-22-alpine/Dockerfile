FROM node:22-alpine

# Install packages for headless chrome
RUN apk update \
    && \
    apk add --no-cache nmap \
    && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
    && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
    && \
    apk update \
    && \
    apk add --no-cache \
        # Packages needed for npm install of mozjpeg & cwebp, can't --virtual and apk del later
        # Pre-builts do not work on alpine for either:
        # ref: https://github.com/imagemin/imagemin/issues/168
        # ref: https://github.com/imagemin/cwebp-bin/issues/27
        autoconf \
        automake \
        build-base \
        g++ \
        gcc \
        glu \
        libc6-compat \
        libtool \
        libpng-dev \
        libxxf86vm \
        make \
        nasm \
        # Misc packages
        nano \
        # Image optimization packages
        gifsicle \
        jpegoptim \
        libpng-dev \
        libwebp-tools \
        libjpeg-turbo-dev \
        libjpeg-turbo-utils \
        optipng \
        pngquant \
        # Headless Chrome packages
        chromium \
        harfbuzz \
        "freetype>2.8" \
        ttf-freefont \
        nss

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
ENV CHROME_BIN /usr/bin/chromium-browser
ENV LIGHTHOUSE_CHROMIUM_PATH /usr/bin/chromium-browser
