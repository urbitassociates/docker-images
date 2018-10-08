FROM nginx:1.10.0-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

ARG PHP_UPSTREAM=php-fpm

COPY auto-reload-nginx.sh /home/auto-reload-nginx.sh
COPY nginx.conf /etc/nginx/
COPY lumen.conf /etc/nginx/conf.d/default.conf
COPY tracking.conf /etc/nginx/conf.d/tracking.conf

RUN echo "upstream php-upstream { server ${PHP_UPSTREAM}:9000; }" > /etc/nginx/conf.d/upstream.conf \
&& chmod +x /home/auto-reload-nginx.sh

# Install & clean up dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    curl \
    shadow \
    inotify-tools \
&& apk --no-cache del \
    wget \
&& rm -rf /var/cache/apk/* /tmp/*

# Set up user
RUN addgroup -S www-data \
&& adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx www-data \
&& usermod -u 1000 www-data

CMD ["/home/auto-reload-nginx.sh"]

WORKDIR /var/www/application

EXPOSE 80 443
