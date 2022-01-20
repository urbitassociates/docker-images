FROM nginx:1.21.5-alpine

ARG PHP_UPSTREAM=php-fpm

ARG UID=1000
ARG GID=2000

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

RUN deluser nginx || true \
    && delgroup nginx || true \
    && addgroup -g $GID -S nginx || true \
    && adduser -u $UID -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx || true

RUN chown nginx /home/auto-reload-nginx.sh \
    && chown -R $UID:0 /var/cache/nginx \
    && chmod -R g+w /var/cache/nginx \
    && chown -R $UID:0 /etc/nginx \
    && chmod -R g+w /etc/nginx

CMD ["/home/auto-reload-nginx.sh"]

WORKDIR /var/www/application

USER nginx

EXPOSE 8080
