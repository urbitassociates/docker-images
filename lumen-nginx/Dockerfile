FROM nginx:1.10.0-alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

ADD nginx.conf /etc/nginx/
ADD lumen.conf /etc/nginx/sites-available/

RUN echo "upstream php-upstream { server php-fpm:9000; }" > /etc/nginx/conf.d/upstream.conf

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    curl \
    shadow

# Remove dependencies
RUN apk --no-cache del \
    wget

# Clean up
RUN rm -rf /var/cache/apk/* /tmp/*

RUN addgroup -S www-data
RUN adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx www-data
RUN usermod -u 1000 www-data

RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

CMD ["nginx"]

WORKDIR /var/www/application

EXPOSE 80 443
