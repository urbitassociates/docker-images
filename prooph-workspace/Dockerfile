FROM prooph/php:7.0-cli-opcache

MAINTAINER Simon Forsman <simon@urb-it.com>

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    git \
    curl \
&& apk --no-cache del \
    wget

# Install Composer & dependencies
RUN curl -sSL http://getcomposer.org/installer | php \
&& mv composer.phar /usr/local/bin/composer \
&& chmod +x /usr/local/bin/composer \
&& composer global require "hirak/prestissimo:^0.3"
