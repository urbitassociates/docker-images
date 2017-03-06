FROM node:6.10

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Environment variables
ENV PHANTOMJS_VERSION 2.1.14

# Install dependencies
RUN apt-get -y update \
 && apt-get -y install \
	ocaml \
	libelf-dev \
 && npm i -g \
	phantomjs-prebuilt@$PHANTOMJS_VERSION \
 && rm -rf /var/cache/apt/archives

WORKDIR /home
