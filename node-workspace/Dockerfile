FROM node:6.8-slim

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Install dependencies
RUN apt-get -y update \
 && apt-get -y install \
	ocaml \
	libelf-dev \
 && npm i -g \
	yarn \
	phantomjs

# Clean up
RUN rm -rf /var/cache/apt/archives

WORKDIR /home
