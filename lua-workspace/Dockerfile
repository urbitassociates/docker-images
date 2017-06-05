FROM alpine:latest
MAINTAINER Jonas Odencrants <jonas.odencrants@urbit.com>

# Environment variables
ENV LUA_VERSION 5.1
ENV ALPINE_VERSION 3.6
ENV LUA_PACKAGE lua${LUA_VERSION}
ENV APPLICATION_PATH  /usr/local/application

# LPUpdate apk index.

RUN echo http://dl-4.alpinelinux.org/alpine/v${ALPINE_VERSION}/main \
echo http://dl-4.alpinelinux.org/alpine/edge/testing \
>> /etc/apk/repositories \
&& echo http://dl-4.alpinelinux.org/alpine/edge/main \
>> /etc/apk/repositories \
&& echo http://dl-4.alpinelinux.org/alpine/edge/community \
>> /etc/apk/repositories \
&& apk --no-cache --update add \
    autoconf \
    build-base \
    ca-certificates \
    ${LUA_PACKAGE} \
    ${LUA_PACKAGE}-dev \
    luarocks${LUA_VERSION} \
    lua${LUA_VERSION}-filesystem \
    lua${LUA_VERSION}-busted \
    openssl-dev \ 
    tar \ 
    g++ \ 
    make \ 
    openssl \ 
    cmake \
    perl \
    gcc \
    unzip \
    curl \
&& ln -s /usr/bin/luarocks-${LUA_VERSION} /usr/bin/luarocks \
&& mkdir -p /root/.cache/luarocks \
&& /usr/bin/luarocks install luacheck  \
&& apk --no-cache del \ 
    wget \
    ${LUA_PACKAGE}-dev \
    luarocks5.1 \
    openssl-dev \ 
    tar \ 
    g++ \ 
    make \ 
    openssl \ 
    cmake \
    build-base \
&& rm -rf /var/cache/apk/* /tmp/* \
&& mkdir ${APPLICATION_PATH}

WORKDIR ${APPLICATION_PATH}
