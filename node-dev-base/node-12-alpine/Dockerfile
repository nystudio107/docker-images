FROM node:12-alpine

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
        # Packages needed for npm install for mozjpeg, can't --virtual and apk del later
        autoconf \
        automake \
        build-base \
		g++ \
		libc-dev \
		libtool \
		libpng-dev \
		make \
		nasm \
		# Misc packages
        nano \
        # Image optimization packages
        gifsicle \
        jpegoptim \
        libpng-dev \
        libwebp-tools \
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
