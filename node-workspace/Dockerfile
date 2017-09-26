FROM node:8.5

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Environment variables
ENV PHANTOMJS_VERSION 2.1.15

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
	ocaml \
	libelf-dev \
 && npm i -g \
	phantomjs-prebuilt@$PHANTOMJS_VERSION \
&& rm -rf /var/lib/apt/lists/* /var/cache/apt/*

WORKDIR /home
