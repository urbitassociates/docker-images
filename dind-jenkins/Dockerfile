FROM docker:dind

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Install Git & SSH
RUN apk add --no-cache \
		git \
		openssh-client \
		py-pip \
		curl \
		lynx

# Install Docker Compose
RUN pip install docker-compose

WORKDIR /home/workspace
