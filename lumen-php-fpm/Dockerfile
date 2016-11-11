FROM php:7.0-fpm-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Add configs
ADD ./lumen.ini /usr/local/etc/php/conf.d
ADD ./lumen.pool.conf /usr/local/etc/php-fpm.d/
ADD ./newrelic.ini /usr/local/etc/php/conf.d

# Environment variables
ENV PHP_API_VERSION 20151012
ENV NEWRELIC_VERSION 6.6.1.172

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    php7-gd \
    php7-sockets \
    php7-zlib \
    php7-intl \
    php7-opcache \
    ca-certificates \
    libpng \
    libpng-dev \
    libjpeg-turbo \
    libjpeg-turbo-dev \
    imagemagick-dev \
    imagemagick \
    autoconf \
    build-base \
    libtool \
    curl \
    icu \
    icu-dev

RUN apk --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ add \
    libressl \
    libressl-dev

#rabbitmq-c is only in testing.
RUN apk --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ add \
    rabbitmq-c \
    rabbitmq-c-dev \
    && pecl install amqp \
    && docker-php-ext-enable amqp

# Download & Install New Relic
RUN curl -#SL https://download.newrelic.com/php_agent/archive/$NEWRELIC_VERSION/newrelic-php5-$NEWRELIC_VERSION-linux-musl.tar.gz | tar xzf -
RUN mv ./newrelic-php5-$NEWRELIC_VERSION-linux-musl/agent/x64/newrelic-$PHP_API_VERSION.so /usr/local/lib/php/extensions/no-debug-non-zts-$PHP_API_VERSION/newrelic.so
RUN mv ./newrelic-php5-$NEWRELIC_VERSION-linux-musl/daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon

RUN chmod 775 /usr/bin/newrelic-daemon
RUN mkdir /var/log/newrelic

RUN docker-php-ext-configure intl

RUN docker-php-ext-configure gd \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/

RUN pecl install imagick \
    && docker-php-ext-install \
        pdo_mysql \
        sockets \
        gd \
        intl \
        opcache \
    && docker-php-ext-enable imagick

# Remove unneeded dependencies & clean up
RUN apk --no-cache del \
    wget \
    icu-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    imagemagick-dev \
    tar \
    autoconf \
    build-base \
    libressl-dev \
    rabbitmq-c-dev \
    libtool

RUN rm -rf /var/cache/apk/* /tmp/* ./newrelic-php5-$NEWRELIC_VERSION-linux-musl*

CMD sh -c "newrelic-daemon && php-fpm"

WORKDIR /var/www/application

EXPOSE 9000
