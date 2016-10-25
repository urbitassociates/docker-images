FROM php:7.0-alpine

MAINTAINER Simon Forsman <simon@urb-it.com>

# Add configs
ADD ./lumen.ini /usr/local/etc/php/conf.d
ADD ./worker.conf /etc/supervisor/worker.conf

ENV PYTHON_VERSION=2.7.12-r0
ENV PY_PIP_VERSION=8.1.2-r0
ENV SUPERVISOR_VERSION=3.3.0

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    php7-sockets \
    php7-gd \
    php7-opcache \
    curl \
    nodejs \
    git \
    php7-zlib \
    php7-intl \
    php7-opcache \
    ca-certificates \
    libpng \
    libjpeg-turbo \
    imagemagick \
    icu \
    python=$PYTHON_VERSION \
    py-pip=$PY_PIP_VERSION

# Install build dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add --virtual build-dependencies \
    icu-dev \
    imagemagick-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    autoconf \
    build-base \
    libtool \
    openssl

# Install supervisor
RUN pip install supervisor==$SUPERVISOR_VERSION

# Install & configure PHP extensions
RUN pecl install imagick \
&& docker-php-ext-configure gd \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
&& docker-php-ext-configure intl \
&& docker-php-ext-install \
    pdo_mysql \
    sockets \
    gd \
    intl \
    opcache \
&& docker-php-ext-enable imagick

# Remove dependencies & clean up
RUN apk --no-cache del \
    wget \
    build-dependencies \
&& rm -rf /var/cache/apk/* /tmp/*

WORKDIR /var/www/application

CMD sh -c "supervisord --nodaemon --configuration /etc/supervisor/worker.conf"
