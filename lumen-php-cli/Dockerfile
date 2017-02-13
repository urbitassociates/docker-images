FROM php:7.1-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

ENV MONGODB_VERSION=1.2.5

# Install dependencies & clean up
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    php7-sockets \
    php7-bcmath \
    curl \
    openssl-dev \
    openssl \
    autoconf \
    build-base \
    icu \
    icu-dev \
&& apk --no-cache del \
    wget 
RUN pecl install \
    mongodb-$MONGODB_VERSION \
&& docker-php-ext-install \
    pdo_mysql \
    sockets \
    intl \
    bcmath \
&& docker-php-ext-enable \
    mongodb

RUN rm -rf /var/cache/apk/* /tmp/* \
&& apk --no-cache del \
    build-base \
    autoconf \
    openssl-dev \
    icu-dev

# Add config & crontab
ADD ./lumen.ini /usr/local/etc/php/conf.d
ADD lumen-scheduler.crontab /lumen-scheduler.crontab
RUN /usr/bin/crontab /lumen-scheduler.crontab

WORKDIR /var/www/application
