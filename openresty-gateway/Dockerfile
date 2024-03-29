FROM openresty/openresty:1.17.8.2-5-alpine

ARG UID=1000
ARG GID=2000

RUN deluser nginx || true \
    && delgroup nginx || true \
    && addgroup -g $GID -S nginx || true \
    && adduser -u $UID -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx || true

# Copy files & set permissions
COPY nginx.conf /usr/local/openresty/nginx/conf/
COPY init-d-nginx /etc/init.d/nginx

RUN mkdir -p /usr/local/api-gateway/nginx/conf.d && \
    mkdir -p /usr/local/api-gateway/nginx/upstream && \
    chmod +x /etc/init.d/nginx

# Install dependencies
RUN echo http://dl-4.alpinelinux.org/alpine/3.8/testing \
>> /etc/apk/repositories \
&& echo http://dl-4.alpinelinux.org/alpine/3.8/main \
>> /etc/apk/repositories \
&& apk --no-cache --update add \
   nettle nettle-dev gcc lua5.1-dev curl perl luarocks5.1 openssl-dev tar g++ make openssl cmake tzdata \
&& ln -s /usr/bin/luarocks-5.1 /usr/bin/luarocks

# mongo-c-driver libbson 1.5.2
RUN cd /tmp \
&& curl -L -O https://github.com/mongodb/mongo-c-driver/releases/download/1.6.0/mongo-c-driver-1.6.0.tar.gz \
&& tar xzf mongo-c-driver-1.6.0.tar.gz \
&& cd mongo-c-driver-1.6.0 \
&& ./configure --disable-automatic-init-and-cleanup \
&& make clean \
&& make \
&& make clean \
&& make install .

RUN /usr/bin/luarocks install mongorover \
&& /usr/bin/luarocks install rapidjson \
&& /usr/bin/luarocks install date \
&& /usr/bin/luarocks install luatz
# Cleanup
RUN apk --no-cache del wget lua5.1-dev openssl-dev tar luarocks5.1 g++ make cmake  \
&& rm -rf /var/cache/apk/* /tmp/*
# Install opm packages
RUN opm install chunpu/shim pintsized/lua-resty-http sumory/lor bungle/lua-resty-nettle=1.5 SkyLothar/lua-resty-jwt

WORKDIR /usr/local/api-gateway

RUN chown -R $UID:0 /usr/local/openresty/nginx

USER nginx

EXPOSE 8080

