FROM alpine:3.4

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

ARG K8S_VERSION=v1.4.6
ARG HELM_VERSION=v2.0.2

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    curl \
    git \
&& apk --no-cache del \
    wget \
&& rm -rf /var/cache/apt/archives

# Kubectl & Helm
RUN curl -#SL -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$K8S_VERSION/bin/linux/amd64/kubectl \
&& chmod +x /usr/local/bin/kubectl \
&& curl -#SL http://storage.googleapis.com/kubernetes-helm/helm-$HELM_VERSION-linux-amd64.tar.gz | tar -xzf - \
&& mv linux-amd64/helm /usr/local/bin/helm \
&& chmod +x /usr/local/bin/helm \
&& mkdir ~/.kube && mkdir ~/.helm

CMD kubectl
