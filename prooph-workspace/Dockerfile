FROM prooph/php:7.0-cli-opcache

MAINTAINER Simon Forsman <simon@urb-it.com>

# Install Composer & dependencies
RUN curl -sSL http://getcomposer.org/installer | php \
&& mv composer.phar /usr/local/bin/composer \
&& chmod +x /usr/local/bin/composer \
&& composer global require "hirak/prestissimo:^0.3"
