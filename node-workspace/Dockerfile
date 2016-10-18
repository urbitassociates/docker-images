FROM node:6.8-slim

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Install dependencies
RUN apt-get update \
 && apt-get install \
	ocaml \
	libelf-dev \
 && npm i \
	yarn -g

# Clean up
RUN rm -rf /var/cache/apt/archives

WORKDIR /home
