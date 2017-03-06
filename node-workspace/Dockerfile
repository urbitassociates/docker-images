FROM node:6.10

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Environment variables
ENV PHANTOMJS_VERSION 2.1.14

# Install dependencies
RUN npm i -g \
	phantomjs-prebuilt@$PHANTOMJS_VERSION

WORKDIR /home
