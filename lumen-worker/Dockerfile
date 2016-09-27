FROM php:7.0-alpine

MAINTAINER Simon Forsman <simon@urb-it.com>

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    php7-sockets \
    php7-gd \
    curl \
    nodejs \
    git \
    php7-zlib \
    php7-intl \
    php7-opcache \
    libpng \
    libpng-dev \
    libjpeg-turbo \
    libjpeg-turbo-dev \
    imagemagick-dev \
    imagemagick \
    autoconf \
    build-base \
    libtool \
    openssl \
    icu \
    icu-dev

# Configure & install extensions using the helper script provided by the base image
RUN docker-php-ext-configure gd \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure intl

# Install extensions using the helper script provided by the base image

RUN pecl install imagick \
    && docker-php-ext-install \
        pdo_mysql \
        sockets \
        gd \
        intl \
        opcache \
    && docker-php-ext-enable imagick

# Run Lumen Worker crontab
ADD lumen-worker.crontab /lumen-worker.crontab
RUN /usr/bin/crontab /lumen-worker.crontab

# Remove dependencies
RUN apk --no-cache del \
    wget \
    icu-dev \
    imagemagick-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    autoconf \
    build-base \
    libtool \
    openssl

# Clean up
RUN rm -rf /var/cache/apk/* /tmp/*

WORKDIR /var/www/application

CMD crond -l 2 -f
