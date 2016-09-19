FROM php:7.0-fpm-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Add configs
ADD ./lumen.ini /usr/local/etc/php/conf.d
ADD ./lumen.pool.conf /usr/local/etc/php-fpm.d/
ADD ./newrelic.ini /usr/local/etc/php/conf.d

# Environment variables
ENV PHP_API_VERSION 20151012
ENV NEWRELIC_VERSION 6.4.0.163

ARG IMAGICK_EXT_VERSION=3.4.2

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    php7-sockets \
    php7-zlib \
    php7-intl \
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
    openssl \
    icu \
    icu-dev

# Download & Install New Relic
RUN curl -#SL https://download.newrelic.com/php_agent/archive/$NEWRELIC_VERSION/newrelic-php5-$NEWRELIC_VERSION-linux-musl.tar.gz | tar xzf -
RUN mv ./newrelic-php5-$NEWRELIC_VERSION-linux-musl/agent/x64/newrelic-$PHP_API_VERSION.so /usr/local/lib/php/extensions/no-debug-non-zts-$PHP_API_VERSION/newrelic.so
RUN mv ./newrelic-php5-$NEWRELIC_VERSION-linux-musl/daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon

RUN chmod 775 /usr/bin/newrelic-daemon
RUN mkdir /var/log/newrelic

RUN docker-php-ext-configure intl
RUN docker-php-ext-install \
    pdo_mysql \
    sockets \
    intl

RUN cd /tmp && wget -q https://pecl.php.net/get/imagick-${IMAGICK_EXT_VERSION}.tgz \
 && tar xzf imagick-${IMAGICK_EXT_VERSION}.tgz && cd imagick-${IMAGICK_EXT_VERSION} \
 && phpize && ./configure && make && make install \
 && echo "extension=imagick.so" > /usr/local/etc/php/conf.d/00_imagick.ini

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
    openssl \
    libtool

RUN rm -rf /var/cache/apk/* /tmp/* ./newrelic-php5-$NEWRELIC_VERSION-linux-musl*

CMD sh -c "newrelic-daemon && php-fpm"

WORKDIR /var/www/application

EXPOSE 9000
