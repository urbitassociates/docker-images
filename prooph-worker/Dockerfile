FROM php:7.3-alpine3.10

MAINTAINER Urbit <pd@urb-it.com>

# Add configs
ADD ./prooph.ini /usr/local/etc/php/conf.d
ADD ./worker.conf /etc/supervisor/worker.conf

# Environment variables
ENV ALPINE_VERSION 3.10
ENV PHP_API_VERSION 20160303
ENV PYTHON_VERSION=2.7.16-r1
ENV PY_PIP_VERSION=18.1-r0
ENV SUPERVISOR_VERSION=3.3.1
ENV MONGODB_VERSION=1.6.1
ENV PHP_AMQP_VERSION=1.9.4

ARG UID=1000
ARG GID=2000

# Install & clean up dependencies
RUN apk --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/v$ALPINE_VERSION/main/ add \
    autoconf \
    build-base \
    ca-certificates \
    python2=$PYTHON_VERSION \
    py2-pip=$PY_PIP_VERSION \
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

RUN && addgroup -g $GID -S prooph || true \
    && adduser -u $UID -D -S -h /var/cache/nginx -s /sbin/nologin -G prooph prooph || true

USER prooph
RUN touch /var/www/application/supervisord.log
CMD sh -c "supervisord --nodaemon --configuration /etc/supervisor/worker.conf"
