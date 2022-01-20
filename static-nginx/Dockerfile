FROM nginx:1.20.1-alpine

COPY auto-reload-nginx.sh /home/auto-reload-nginx.sh
COPY nginx.conf /etc/nginx/
COPY default.conf /etc/nginx/conf.d/default.conf

RUN chmod +x /home/auto-reload-nginx.sh

ARG UID=1000
ARG GID=2000

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

# Set up logging
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["/home/auto-reload-nginx.sh"]

WORKDIR /var/www/application

USER nginx

EXPOSE 8080
