FROM prooph/php:7.0-cli-opcache

MAINTAINER Simon Forsman <simon@urb-it.com>

# Install Composer
RUN curl -sSL http://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer
