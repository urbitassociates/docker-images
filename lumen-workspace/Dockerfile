FROM php:7.1-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Environment variables
ENV ALPINE_VERSION 3.4
ENV PHP_API_VERSION 20160303
ENV NEWRELIC_VERSION 7.0.0.186
ENV IMAGICK_VERSION=3.4.3
# ENV AMQP_VERSION=1.8.0
ENV MONGODB_VERSION=1.2.5

# Download & Install New Relic
RUN curl -#SL https://download.newrelic.com/php_agent/archive/$NEWRELIC_VERSION/newrelic-php5-$NEWRELIC_VERSION-linux-musl.tar.gz | tar xzf - \
&& mv ./newrelic-php5-$NEWRELIC_VERSION-linux-musl/agent/x64/newrelic-$PHP_API_VERSION.so /usr/local/lib/php/extensions/no-debug-non-zts-$PHP_API_VERSION/newrelic.so \
&& mv ./newrelic-php5-$NEWRELIC_VERSION-linux-musl/daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon \
&& chmod 775 /usr/bin/newrelic-daemon \
&& mkdir /var/log/newrelic

# Install & clean up dependencies
RUN apk --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/v$ALPINE_VERSION/main/ add \
    autoconf \
    build-base \
    ca-certificates \
&& apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/main/ add \
    curl \
    openssl \
    openssl-dev \
    libtool \
    icu \
    icu-libs \
    icu-dev \
    libwebp \
    libpng \
    libpng-dev \
    libjpeg-turbo \
    libjpeg-turbo-dev \
    imagemagick-dev \
    imagemagick \
&& apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    php7-gd \
    php7-sockets \
    php7-zlib \
    php7-intl \
    php7-opcache \
    php7-bcmath \
    nodejs \
    git \
&& docker-php-ext-configure intl \
&& docker-php-ext-configure gd \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
&& pecl install \
    imagick-$IMAGICK_VERSION \
    # amqp-$AMQP_VERSION \
    mongodb-$MONGODB_VERSION \
&& docker-php-ext-install \
    pdo_mysql \
    sockets \
    gd \
    intl \
    opcache \
    bcmath \
&& docker-php-ext-enable \
    imagick \
    # amqp \
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
    libtool \
&& rm -rf /var/cache/apk/* /tmp/* ./newrelic-php5-$NEWRELIC_VERSION-linux-musl*

# Install Composer & dependencies
RUN curl -sSL http://getcomposer.org/installer | php \
&& mv composer.phar /usr/local/bin/composer \
&& chmod +x /usr/local/bin/composer \
&& composer global require "hirak/prestissimo:^0.3"

# Run Lumen Scheduler crontab
ADD lumen-scheduler.crontab /lumen-scheduler.crontab
RUN /usr/bin/crontab /lumen-scheduler.crontab

WORKDIR /var/www/application

CMD crond -l 2 -f
