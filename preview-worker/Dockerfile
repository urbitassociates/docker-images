FROM alpine:3.4

MAINTAINER Simon Forsman <simon@urb-it.com>

ENV SUPERVISOR_VERSION=3.3.1
ENV GOPATH /go
ENV GO15VENDOREXPERIMENT 1
ENV KUBE_VERSION="v1.4.6"
ENV HELM_VERSION="v2.0.2"
ENV HELM_FILENAME="helm-${HELM_VERSION}-linux-amd64.tar.gz"

ADD ./worker.conf /etc/supervisord.conf

# Install dependencies
RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing \
>> /etc/apk/repositories \
&& echo http://dl-4.alpinelinux.org/alpine/edge/main \
>> /etc/apk/repositories \
&& echo http://dl-4.alpinelinux.org/alpine/edge/community \
>> /etc/apk/repositories \
&& apk --no-cache --update add \
   gcc \
   curl \
   perl \
   openssl-dev \
   tar \
   unzip \
   g++ \
   git \
   make \
   cmake \
   openssl \
   go \
   ca-certificates \
   luajit \
   py-pip \
&& update-ca-certificates \
&& curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && curl -L http://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME} -o /tmp/${HELM_FILENAME} \
    && tar -zxvf /tmp/${HELM_FILENAME} -C /tmp \
    && mv /tmp/linux-amd64/helm /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm && helm init -c && helm repo add urbit http://charts.urb-it.io \
&& go get github.com/urbitassociates/cli53 ;\
    cd $GOPATH/src/github.com/urbitassociates/cli53 ;\
    make install \
&& pip install \
    supervisor==$SUPERVISOR_VERSION \
    supervisor-stdout \
    redis \
    enum34 \
&& apk --no-cache del \
    wget \
    openssl-dev \
    tar \
    gcc \
    g++ \
    git \
    make \
    cmake \
    unzip \
    go \
&& rm -rf /var/cache/apk/* /tmp/* $GOPATH/src

WORKDIR /var/application

ENTRYPOINT ["/bin/sh", "-c", "supervisord", "--nodaemon" ,"--configuration /etc/supervisord.conf"]
