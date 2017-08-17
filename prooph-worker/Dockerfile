FROM php:7.2-rc-alpine

MAINTAINER Simon Forsman <simon@urb-it.com>

# Add configs
ADD ./prooph.ini /usr/local/etc/php/conf.d
ADD ./worker.conf /etc/supervisor/worker.conf

# Environment variables
ENV ALPINE_VERSION 3.4
ENV PHP_API_VERSION 20160303
ENV NEWRELIC_VERSION 7.0.0.186
ENV PYTHON_VERSION=2.7.12-r0
ENV PY_PIP_VERSION=8.1.2-r0
ENV SUPERVISOR_VERSION=3.3.1
ENV MONGODB_VERSION=1.2.9
ENV PHP_AMQP_VERSION=1.9.1

# Download & Install New Relic
RUN curl -#SL https://download.newrelic.com/php_agent/archive/$NEWRELIC_VERSION/newrelic-php5-$NEWRELIC_VERSION-linux-musl.tar.gz | tar xzf - \
&& mkdir -p /usr/local/lib/php/extensions/no-debug-non-zts-$PHP_API_VERSION \
&& mv ./newrelic-php5-$NEWRELIC_VERSION-linux-musl/agent/x64/newrelic-$PHP_API_VERSION.so /usr/local/lib/php/extensions/no-debug-non-zts-$PHP_API_VERSION/newrelic.so \
&& mv ./newrelic-php5-$NEWRELIC_VERSION-linux-musl/daemon/newrelic-daemon.x64 /usr/bin/newrelic-daemon \
&& chmod 775 /usr/bin/newrelic-daemon \
&& mkdir /var/log/newrelic

# Install & clean up dependencies
RUN apk --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/v$ALPINE_VERSION/main/ add \
    autoconf \
    build-base \
    ca-certificates \
    python=$PYTHON_VERSION \
    py-pip=$PY_PIP_VERSION \
&& apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/main/ add \
    curl \
    libressl \
    libressl-dev \
    rabbitmq-c \
    rabbitmq-c-dev \
    libtool \
    icu \
    icu-libs \
    icu-dev \
    libwebp \
&& apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    php7-sockets \
    php7-zlib \
    php7-intl \
    php7-opcache \
    php7-bcmath \
&& docker-php-ext-configure intl \
&& pecl install \
    mongodb-$MONGODB_VERSION \
    amqp-$PHP_AMQP_VERSION \
&& docker-php-ext-install \
    sockets \
    intl \
    opcache \
    bcmath \
&& docker-php-ext-enable \
    mongodb \
    amqp \
&& apk --no-cache del \
    wget \
    icu-dev \
    tar \
    autoconf \
    build-base \
    rabbitmq-c-dev \
    libtool \
&& rm -rf /var/cache/apk/* /tmp/* ./newrelic-php5-$NEWRELIC_VERSION-linux-musl*

# Install supervisor
RUN pip install supervisor==$SUPERVISOR_VERSION

WORKDIR /var/www/application

CMD sh -c "supervisord --nodaemon --configuration /etc/supervisor/worker.conf"
