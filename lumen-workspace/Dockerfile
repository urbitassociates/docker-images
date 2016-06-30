FROM php:7.0-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ add \
    curl \
    shadow \
    nodejs \
    git

# Remove dependencies
RUN apk --no-cache del \
    wget

# Install Composer
RUN curl -sSL http://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Add group & user
RUN addgroup -S workspace
RUN adduser -D -S -h /var/www/application -s /sbin/nologin -G workspace workspace
RUN usermod -u 1000 workspace
RUN chown -R workspace:workspace /home

# Clean up
RUN rm -rf /var/cache/apk/* /tmp/*

USER workspace

WORKDIR /var/www/application
