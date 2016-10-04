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
    libpng-dev \
    libjpeg-turbo \
    libjpeg-turbo-dev \
    imagemagick-dev \
    imagemagick \
    autoconf \
    build-base \
    libtool \
    openssl \
    icu \
    icu-dev \
    python=$PYTHON_VERSION \
    py-pip=$PY_PIP_VERSION

# Install supervisor
RUN pip install supervisor==$SUPERVISOR_VERSION

# Configure & install extensions using the helper script provided by the base image
RUN docker-php-ext-configure gd \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure intl

# Install extensions using the helper script provided by the base image

RUN pecl install imagick \
    && docker-php-ext-install \
        pdo_mysql \
        sockets \
        gd \
        intl \
        opcache \
    && docker-php-ext-enable imagick

# Remove dependencies
RUN apk --no-cache del \
    wget \
    icu-dev \
    imagemagick-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    autoconf \
    build-base \
    libtool \
    openssl

# Clean up
RUN rm -rf /var/cache/apk/* /tmp/*

WORKDIR /var/www/application

CMD sh -c "supervisord --nodaemon --configuration /etc/supervisor/worker.conf"
