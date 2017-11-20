FROM alpine:3.4

MAINTAINER Urb-it AB <teknik@urb-it.com>

ENV SUPERVISOR_VERSION=3.3.3

ADD ./worker.conf /etc/supervisord.conf

# Install dependencies
RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing \
>> /etc/apk/repositories \
&& echo http://dl-4.alpinelinux.org/alpine/edge/main \
>> /etc/apk/repositories \
&& echo http://dl-4.alpinelinux.org/alpine/edge/community \
>> /etc/apk/repositories \
&& apk --no-cache --update add \
   openssl-dev \
   openssl \
   ca-certificates \
   python3 \
&& update-ca-certificates \
&& python3 -m ensurepip \
&& rm -r /usr/lib/python*/ensurepip \
&& pip3 install --upgrade pip setuptools \
&& if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi \
&& if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi \
&& rm -r /root/.cache \
&& pip install \
    supervisor==$SUPERVISOR_VERSION \
    supervisor-stdout \
    redis \
&& apk --no-cache del \
    wget \
    openssl-dev \
&& rm -rf /var/cache/apk/* /tmp/*

WORKDIR /usr/local/worker

ENTRYPOINT ["/bin/sh", "-c", "supervisord", "--nodaemon" ,"--configuration /etc/supervisord.conf"]
