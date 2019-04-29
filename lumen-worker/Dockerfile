FROM php:7.1-alpine

# Add configs
ADD ./lumen.ini /usr/local/etc/php/conf.d
ADD ./worker.conf /etc/supervisor/worker.conf

# Environment variables
ENV ALPINE_VERSION 3.4
ENV PHP_API_VERSION 20160303
ENV PYTHON_VERSION=2.7.12-r0
ENV PY_PIP_VERSION=8.1.2-r0
ENV SUPERVISOR_VERSION=3.3.1
ENV IMAGICK_VERSION=3.4.3
# ENV AMQP_VERSION=1.8.0
ENV MONGODB_VERSION=1.2.5

# Install & clean up dependencies
RUN apk --no-cache --update --repository http://dl-cdn.alpinelinux.org/alpine/v$ALPINE_VERSION/main/ add \
    autoconf \
    build-base \
    ca-certificates \
    python=$PYTHON_VERSION \
    py-pip=$PY_PIP_VERSION \
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
&& rm -rf /var/cache/apk/* /tmp/*

# Install supervisor
RUN pip install supervisor==$SUPERVISOR_VERSION

WORKDIR /var/www/application

CMD sh -c "supervisord --nodaemon --configuration /etc/supervisor/worker.conf"
