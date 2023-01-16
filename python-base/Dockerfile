FROM python:3.9-alpine3.17

RUN python -m pip install --upgrade pip

# Install dependencies
RUN apk --update add \
    ca-certificates \
    openssl \
    tini \
    g++ \
    gdal \
    geos \
    --update-cache \
    --repository http://dl-3.alpinelinux.org/alpine/v3.17/community --allow-untrusted \
    --repository http://dl-3.alpinelinux.org/alpine/edge/community --allow-untrusted \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing --allow-untrusted \
    --repository http://dl-3.alpinelinux.org/alpine/edge/main --allow-untrusted

RUN apk --update add --virtual build-dependencies \
        build-base \
        gdal-dev \
        geos-dev \
        --update-cache \
        --repository http://dl-3.alpinelinux.org/alpine/v3.17/community --allow-untrusted \
        --repository http://dl-3.alpinelinux.org/alpine/edge/community --allow-untrusted \
        --repository http://dl-3.alpinelinux.org/alpine/edge/testing --allow-untrusted \
        --repository http://dl-3.alpinelinux.org/alpine/edge/main --allow-untrusted \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && pip install gunicorn \
    && pip install gevent \
    && pip install cython \
    && pip install numpy 
    
# Remove dependencies & clean up
RUN apk --no-cache del \
    wget \
    build-dependencies \
&& rm -rf /var/cache/apk/* /tmp/*
