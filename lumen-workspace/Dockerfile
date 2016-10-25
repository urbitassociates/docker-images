FROM php:7.0-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

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
    libjpeg-turbo \
    imagemagick \
    icu

# Install build dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add --virtual build-dependencies \
    icu-dev \
    imagemagick-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    autoconf \
    build-base \
    libtool \
    openssl

# Install Composer
RUN curl -sSL http://getcomposer.org/installer | php \
&& mv composer.phar /usr/local/bin/composer \
&& chmod +x /usr/local/bin/composer

# Install & configure PHP extensions
RUN pecl install imagick \
&& docker-php-ext-configure gd \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-configure intl \
&& docker-php-ext-install \
    pdo_mysql \
    sockets \
    gd \
    intl \
    opcache \
&& docker-php-ext-enable imagick

# Run Lumen Scheduler crontab
ADD lumen-scheduler.crontab /lumen-scheduler.crontab
RUN /usr/bin/crontab /lumen-scheduler.crontab

# Remove dependencies & clean up
RUN apk --no-cache del \
    wget \
    build-dependencies \
&& rm -rf /var/cache/apk/* /tmp/*

WORKDIR /var/www/application

CMD crond -l 2 -f
