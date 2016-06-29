FROM php:7.0-fpm-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

ADD ./lumen.ini /usr/local/etc/php/conf.d
ADD ./lumen.pool.conf /usr/local/etc/php-fpm.d/

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ add \
    php7-sockets

# Remove dependencies
RUN apk --no-cache del \
    wget

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install \
    pdo_mysql \
    sockets

# Clean up
RUN rm -rf /var/cache/apk/* /tmp/*

# RUN usermod -u 1000 www-data

CMD ["php-fpm"]

WORKDIR /var/www/application

EXPOSE 9000
