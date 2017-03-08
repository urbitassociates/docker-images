FROM golang:1.8-alpine

ENV PATH /go/bin:$PATH

# Install dependencies
RUN apk --no-cache --update --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    curl \
    glide \
    git \
    make \
&& apk --no-cache del \
    wget

WORKDIR /go
