FROM nginx:alpine

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

ADD nginx.conf /etc/nginx/
ADD lumen.conf /etc/nginx/sites-available/

RUN echo "upstream php-upstream { server php-fpm:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ add shadow

RUN addgroup -S www-data
RUN adduser -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx www-data
RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80 443
