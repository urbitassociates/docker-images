FROM php:7.0-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ add \
    php7-sockets \
    curl \
    nodejs \
    git

# Remove dependencies
RUN apk --no-cache del \
    wget

# Install Composer
RUN curl -sSL http://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install \
    pdo_mysql \
    sockets

# Clean up
RUN rm -rf /var/cache/apk/* /tmp/*

WORKDIR /var/www/application

CMD true
