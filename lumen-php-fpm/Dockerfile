FROM php:7.0-fpm-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Add configs
ADD ./lumen.ini /usr/local/etc/php/conf.d
ADD ./lumen.pool.conf /usr/local/etc/php-fpm.d/
ADD ./newrelic.ini /usr/local/etc/php/conf.d

# Environment variables
ENV PHP_API_VERSION 20151012
ENV NEWRELIC_VERSION 6.4.0.163

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ add \
    php7-sockets \
    ca-certificates \
    curl

# Remove dependencies
RUN apk --no-cache del \
    wget

# Download & Install New Relic
RUN curl -sSL https://download.newrelic.com/php_agent/archive/$NEWRELIC_VERSION/newrelic-php5-$NEWRELIC_VERSION-linux-musl.tar.gz | tar xvzf -
RUN mv ./newrelic-php5-$NEWRELIC_VERSION-linux-musl/agent/x64/newrelic-$PHP_API_VERSION.so /usr/local/lib/php/extensions/no-debug-non-zts-$PHP_API_VERSION/newrelic.so
RUN mv ./newrelic-php5-$NEWRELIC_VERSION-linux-musl/daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon

RUN chmod 775 /usr/bin/newrelic-daemon
RUN mkdir /var/log/newrelic

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install \
    pdo_mysql \
    sockets

# Clean up
RUN rm -rf /var/cache/apk/* /tmp/* ./newrelic-php5-$NEWRELIC_VERSION-linux-musl*

# RUN usermod -u 1000 www-data

CMD sh -c "newrelic-daemon && php-fpm"

WORKDIR /var/www/application

EXPOSE 9000
