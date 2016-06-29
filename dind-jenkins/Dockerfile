FROM docker:dind

MAINTAINER Sebastian Mandrean <sebastian@urb-it.com>

# Install Git & SSH
RUN apk add --no-cache \
    git \
    openssh-client \
    py-pip \
    curl

# Remove dependencies
RUN apk --no-cache del \
    wget

# Install Docker Compose
RUN pip install docker-compose

# Clean up
RUN rm -rf /var/cache/apk/* /tmp/*

WORKDIR /home/workspace
