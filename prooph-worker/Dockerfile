FROM php:7.3-alpine3.13

MAINTAINER Urbit <pd@urb-it.com>

# Add configs
ADD ./prooph.ini /usr/local/etc/php/conf.d
ADD ./worker.conf /etc/supervisor/worker.conf

# Environment variables
ENV ALPINE_VERSION 3.13
ENV PHP_API_VERSION 20160303
ENV PYTHON_VERSION=3.8.10-r0
ENV PY_PIP_VERSION=20.3.4-r0
ENV SUPERVISOR_VERSION=4.2.4
ENV MONGODB_VERSION=1.6.1
ENV PHP_AMQP_VERSION=1.9.4

ARG UID=1000
ARG GID=2000

# Install & clean up dependencies
RUN apk --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/v$ALPINE_VERSION/main/ add \
    autoconf \
    build-base \
    ca-certificates \
    python3=$PYTHON_VERSION \
    py3-pip=$PY_PIP_VERSION \
    curl \
    openssl \
    openssl-dev \
    rabbitmq-c \
    rabbitmq-c-dev \
    libtool \
    icu \
    icu-libs \
    icu-dev \
    libwebp

RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/v$ALPINE_VERSION/community/ add \
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
RUN pip3 install supervisor==$SUPERVISOR_VERSION

WORKDIR /var/www/application

RUN addgroup -g $GID -S prooph || true \
    && adduser -u $UID -D -S -h /var/cache/nginx -s /sbin/nologin -G prooph prooph || true

RUN chown -R prooph:prooph /var/www/application

USER prooph
RUN touch /var/www/application/supervisord.log
CMD sh -c "supervisord --nodaemon --configuration /etc/supervisor/worker.conf"
