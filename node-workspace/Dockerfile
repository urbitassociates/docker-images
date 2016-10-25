FROM node:6.8

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Update, install & clean up dependencies
RUN apt-get -y update \
&& apt-get -y install \
	ocaml \
	libelf-dev \
&& rm -rf /var/cache/apt/archives
RUN npm i -g \
	yarn \
	webpack \
	phantomjs \
&& npm clean cache

WORKDIR /home
