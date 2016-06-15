FROM php:7.0-fpm-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

ADD ./lumen.ini /usr/local/etc/php/conf.d
ADD ./lumen.pool.conf /usr/local/etc/php-fpm.d/

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install \
    pdo_mysql

# RUN usermod -u 1000 www-data

CMD ["php-fpm"]

EXPOSE 9000
