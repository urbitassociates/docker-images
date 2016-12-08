FROM nginx:stable-alpine

MAINTAINER Denis Koltsov <denis@urbit.com>

COPY auto-reload-nginx.sh /home/auto-reload-nginx.sh
COPY nginx.conf /etc/nginx/
COPY default.conf /etc/nginx/conf.d/default.conf

RUN chmod +x /home/auto-reload-nginx.sh

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

# Set up logging
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["/home/auto-reload-nginx.sh"]

WORKDIR /var/www/application

EXPOSE 80
