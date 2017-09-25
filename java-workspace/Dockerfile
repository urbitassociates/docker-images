FROM openjdk:8-jre

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Environment variables
ENV YARN_VERSION 1.0.2

# Add nodejs repo
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# Install & clean up dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
	ocaml \
	libelf-dev \
	nodejs \
	git \
&& npm i -g \
	yarn@$YARN_VERSION \
&& rm -rf /var/lib/apt/lists/* /var/cache/apt/*

WORKDIR /home
