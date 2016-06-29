FROM php:7.0-fpm-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

ADD ./lumen.ini /usr/local/etc/php/conf.d
ADD ./lumen.pool.conf /usr/local/etc/php-fpm.d/
ADD ./newrelic.ini /usr/local/etc/php/conf.d

ENV NEWRELIC_VERSION 6.4.0.163

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ add \
    php7-sockets \
    ca-certificates \
    curl

# Remove dependencies
RUN apk --no-cache del \
    wget

RUN curl -sSL https://download.newrelic.com/php_agent/archive/$NEWRELIC_VERSION/newrelic-php5-$NEWRELIC_VERSION-linux-musl.tar.gz | tar xvzf -

RUN mv ./newrelic-php5-$NEWRELIC_VERSION-linux-musl/agent/x64/newrelic-20151012.so /usr/local/lib/php/extensions/no-debug-non-zts-20151012/newrelic.so

RUN mv ./newrelic-php5-$NEWRELIC_VERSION-linux-musl/daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon

RUN rm -rf ./newrelic-php5-$NEWRELIC_VERSION-linux-musl*

RUN chmod 775 /usr/bin/newrelic-daemon

RUN mkdir /var/log/newrelic

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install \
    pdo_mysql \
    sockets

# Clean up
RUN rm -rf /var/cache/apk/* /tmp/*

# RUN usermod -u 1000 www-data

ENTRYPOINT sh -c "newrelic-daemon && php-fpm"

WORKDIR /var/www/application

EXPOSE 9000
