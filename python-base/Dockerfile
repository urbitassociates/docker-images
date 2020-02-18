FROM python:3.6-alpine3.10

# Lock pip to version 9
RUN python -m pip install -U 'pip>=9,<10'

# Install dependencies
RUN apk --update add \
    ca-certificates \
    openssl \
    tini \
    g++ \
    gdal \
    geos \
    --update-cache \
    --repository http://dl-3.alpinelinux.org/alpine/3.10/community --allow-untrusted \
    --repository http://dl-3.alpinelinux.org/alpine/edge/community --allow-untrusted \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing --allow-untrusted \
    --repository http://dl-3.alpinelinux.org/alpine/edge/main --allow-untrusted

RUN apk --update add --virtual build-dependencies \
        build-base \
        gdal-dev \
        geos-dev \
        --update-cache \
        --repository http://dl-3.alpinelinux.org/alpine/3.10/community --allow-untrusted \
        --repository http://dl-3.alpinelinux.org/alpine/edge/community --allow-untrusted \
        --repository http://dl-3.alpinelinux.org/alpine/edge/testing --allow-untrusted \
        --repository http://dl-3.alpinelinux.org/alpine/edge/main --allow-untrusted \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && pip install gunicorn \
    && pip install gevent
    
# Remove dependencies & clean up
RUN apk --no-cache del \
    wget \
    build-dependencies \
&& rm -rf /var/cache/apk/* /tmp/*
