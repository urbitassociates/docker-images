FROM php:7.0-fpm-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Add configs
ADD ./logging.ini /usr/local/etc/php/conf.d
ADD ./lumen.ini /usr/local/etc/php/conf.d
ADD ./lumen.pool.conf /usr/local/etc/php-fpm.d
ADD ./newrelic.ini /usr/local/etc/php/conf.d

# Environment variables
ENV PHP_API_VERSION 20151012
ENV NEWRELIC_VERSION 6.6.1.172

# Download & Install New Relic
RUN curl -#SL https://download.newrelic.com/php_agent/archive/$NEWRELIC_VERSION/newrelic-php5-$NEWRELIC_VERSION-linux-musl.tar.gz | tar xzf - \
&& mv ./newrelic-php5-$NEWRELIC_VERSION-linux-musl/agent/x64/newrelic-$PHP_API_VERSION.so /usr/local/lib/php/extensions/no-debug-non-zts-$PHP_API_VERSION/newrelic.so \
&& mv ./newrelic-php5-$NEWRELIC_VERSION-linux-musl/daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon \
&& chmod 775 /usr/bin/newrelic-daemon \
&& mkdir /var/log/newrelic

# Install & clean up dependencies
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
    icu-dev \
&& apk --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ add \
    libressl \
    libressl-dev \
&& apk --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/ add \
    rabbitmq-c \
    rabbitmq-c-dev \
    && pecl install amqp \
    && docker-php-ext-enable amqp \
&& docker-php-ext-configure intl \
&& docker-php-ext-configure gd \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
&& pecl install \
    imagick \
    mongodb \
&& docker-php-ext-install \
    pdo_mysql \
    sockets \
    gd \
    intl \
    opcache \
&& docker-php-ext-enable \
    imagick \
    mongodb \
&& apk --no-cache del \
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
    libtool \
&& rm -rf /var/cache/apk/* /tmp/* ./newrelic-php5-$NEWRELIC_VERSION-linux-musl*

# Workaround for piping PHP-FPM worker logs to the container log output
# https://bugs.php.net/bug.php?id=71880
RUN mkfifo /tmp/stdout && chmod 777 /tmp/stdout

CMD sh -c "newrelic-daemon && php-fpm"

WORKDIR /var/www/application

EXPOSE 9000
