FROM openjdk:8-jre-buster

LABEL maintainer="pd@urbit.com"

# Environment variables
ENV YARN_VERSION 1.0.2

# Add nodejs repo
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

# Install & clean up dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
	ocaml \
	libelf-dev \
	nodejs \
	git \
	build-essential \
	&& npm i -g \
	yarn@$YARN_VERSION \
	&& rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Set /usr/bin/python to be v3.7
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1

WORKDIR /home
