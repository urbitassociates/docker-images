FROM nginx:1.10.0-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

ADD nginx.conf /etc/nginx/
ADD lumen.conf /etc/nginx/sites-available/

RUN echo "upstream php-upstream { server 127.0.0.1:9000; }" > /etc/nginx/conf.d/upstream.conf

# Install, remove and clean up dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    curl \
    shadow \
&& apk --no-cache del wget \
&& rm -rf /var/cache/apk/* /tmp/*

# Configure users
RUN addgroup -S www-data \
&& adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx www-data \
&& usermod -u 1000 www-data

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["nginx"]

WORKDIR /var/www/application

EXPOSE 80 443
