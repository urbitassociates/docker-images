FROM node:6.8

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Environment variables
ENV PHANTOMJS_VERSION 2.1.13

# Install dependencies
RUN apt-get -y update \
 && apt-get -y install \
	ocaml \
	libelf-dev \
 && npm i -g \
	yarn \
	phantomjs-prebuilt@PHANTOMJS_VERSION

# Clean up
RUN rm -rf /var/cache/apt/archives

WORKDIR /home
