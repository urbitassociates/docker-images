FROM openresty/openresty:alpine

MAINTAINER Jonas Odencrants <jonas.odencrants@urbit.com>

ENV GOPATH /go
ENV PATH $PATH:$GOPATH/bin

# Copy files & set permissions
COPY nginx.conf /usr/local/openresty/nginx/conf/
COPY init-d-nginx /etc/init.d/nginx
COPY start-geoip-service.sh /usr/local/bin
COPY update-database.sh /etc/periodic/daily
RUN mkdir /go \
&& chmod +x /usr/local/bin/start-geoip-service.sh \
&& chmod +x /etc/init.d/nginx \
&& chmod +x /etc/periodic/daily/update-database.sh

# Install dependencies
RUN apk --no-cache --update add \
    go \
    curl \
    perl \
&& apk --no-cache del \
    wget \
&& apk --no-cache --update add --virtual build-dependencies \
    git \
    musl-dev \
    autoconf \
    automake \
    libtool \
    make \
    zlib-dev \
    curl-dev

RUN opm install chunpu/shim
# Install and Configure GeoIP service
RUN go get github.com/klauspost/geoip-service \
&& git clone https://github.com/maxmind/geoipupdate && \
  cd geoipupdate && \
  ./bootstrap && \
  ./configure && \
  make && \
  make install && \
  mkdir /usr/local/share/GeoIP

# Remove dependencies & clean up
RUN apk --no-cache del \
    wget \
    build-dependencies \
&& rm -rf /var/cache/apk/* /tmp/*

# Set up container logging
RUN ln -sf /dev/stdout /usr/local/openresty/nginx/logs/access.log && \
    ln -sf /dev/stderr /usr/local/openresty/nginx/logs/error.log

# Start services
ENTRYPOINT ["/usr/local/bin/start-geoip-service.sh"]

WORKDIR /usr/local/openresty/nginx

EXPOSE 80 443 5000
