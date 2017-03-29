FROM openresty/openresty:alpine

MAINTAINER Jonas Odencrants <jonas.odencrants@urbit.com>

## Configure nginx with API augmenting

COPY nginx.conf /usr/local/openresty/nginx/conf/

COPY init-d-nginx /etc/init.d/nginx
RUN chmod +x /etc/init.d/nginx

## Set up container logging
RUN ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log && \
    ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log

## Install dependencies
RUN  apk update && \
     apk upgrade && \
     apk add git && \
     apk add go && \
     apk add musl-dev && \
     apk add autoconf && \
     apk add automake && \
     apk add libtool && \
     apk add make && \
     apk add zlib-dev && \
     apk add curl-dev && \
     apk --no-cache del && \
     rm -rf /var/cache/apk/* /tmp/*

## Configure go
RUN mkdir /go
ENV GOPATH /go
ENV GOPATH=/go
RUN echo 'export GOPATH=/go' >> /etc/profile
RUN echo 'export PATH=$PATH:$GOPATH/bin' >> /etc/profile

## Install and Confgiure geoip service
RUN go get github.com/klauspost/geoip-service
COPY start-geoip-service.sh /usr/local/bin
RUN chmod +x /usr/local/bin/start-geoip-service.sh

RUN git clone https://github.com/maxmind/geoipupdate && \
  cd geoipupdate && \
  ./bootstrap && \
  ./configure && \
  make && \
  make install && \
  mkdir /usr/local/share/GeoIP

## Install periodic job to update database

COPY update-database.sh /etc/periodic/daily
RUN chmod +x /etc/periodic/daily/update-database.sh

## Perform cleanup of build tools

RUN apk del autoconf && \
    apk del automake && \
    apk del libtool && \
    apk del make && \
    apk del zlib-dev && \
    apk del git

## Start services
ENTRYPOINT ["/usr/local/bin/start-geoip-service.sh"]

WORKDIR /usr/local/openresty/nginx

EXPOSE 80 443 5000

