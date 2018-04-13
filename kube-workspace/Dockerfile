FROM alpine:3.4

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

ARG K8S_VERSION=1.7.5
ARG HELM_VERSION=2.6.2

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    curl \
    git \
&& apk --no-cache del \
    wget \
&& rm -rf /var/cache/apt/archives

# Install kubectl & helm
RUN curl -#SL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v$K8S_VERSION/bin/linux/amd64/kubectl \
&& chmod +x /usr/local/bin/kubectl \
&& curl -#SL https://storage.googleapis.com/kubernetes-helm/helm-v$HELM_VERSION-linux-amd64.tar.gz | tar zxvf - \
&& mv linux-amd64/helm /usr/local/bin/helm && rm -rf linux-amd64 \
&& chmod +x /usr/local/bin/helm \
&& mkdir -p ~/.kube && helm init -c

WORKDIR /home

CMD kubectl
