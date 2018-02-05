FROM python:3.5-alpine

MAINTAINER Jonas Odencrants <jonas.odencrants@urbit.com>

COPY requirements.txt .

# Install dependencies

RUN apk --update add --virtual build-dependencies \
        ca-certificates \
        openssl \
        tini \
        g++ \
        build-base \
        --update-cache \
        --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
        --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && pip3 install -r requirements.txt

# Remove dependencies & clean up
RUN apk --no-cache del \
    wget \
    build-dependencies \
&& rm -rf /var/cache/apk/* /tmp/*
