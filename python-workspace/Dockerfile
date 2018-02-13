FROM quay.io/urbit/gunicorn-python:latest

MAINTAINER Jonas Odencrants <jonas.odencrants@urbit.com>

COPY requirements.txt .
COPY pep8 /root/.config/pep8
COPY flake8 /root/.config/flake8
# Install dependencies

RUN apk --update add \
    gdal \
    geos \
    geos-dev \
    gdal-dev \
    build-base \
    --update-cache \
    --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
&& pip3 install -r requirements.txt

# Remove dependencies & clean up
RUN apk --no-cache del \
    wget \
&& rm -rf /var/cache/apk/* /tmp/*
