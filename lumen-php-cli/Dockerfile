FROM php:7.0-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Install dependencies & clean up
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    php7-sockets \
    php7-intl \
    curl \
&& apk --no-cache del \
    wget \
&& docker-php-ext-install \
    pdo_mysql \
    sockets \
    intl \
&& rm -rf /var/cache/apk/* /tmp/*

# Add config & crontab
ADD ./lumen.ini /usr/local/etc/php/conf.d
ADD lumen-scheduler.crontab /lumen-scheduler.crontab
RUN /usr/bin/crontab /lumen-scheduler.crontab

WORKDIR /var/www/application
