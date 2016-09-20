FROM php:7.0-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    php7-sockets \
    curl \
    nodejs \
    git \
    php7-gd \
    php7-zlib \
    php7-intl \
    php7-opcache \
    libpng \
    libpng-dev \
    libjpeg-turbo \
    libjpeg-turbo-dev \
    icu \
    icu-dev

# Install Composer
RUN curl -sSL http://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Configure & install extensions using the helper script provided by the base image
RUN docker-php-ext-configure gd \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure intl

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install \
    pdo_mysql \
    sockets \
    gd \
    intl \
    opcache

# Run Lumen Scheduler crontab
ADD lumen-scheduler.crontab /lumen-scheduler.crontab
RUN /usr/bin/crontab /lumen-scheduler.crontab

# Remove dependencies
RUN apk --no-cache del \
    wget \
    icu-dev

# Clean up
RUN rm -rf /var/cache/apk/* /tmp/*

WORKDIR /var/www/application

CMD crond -l 2 -f
