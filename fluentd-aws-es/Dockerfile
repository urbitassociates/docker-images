FROM centos:7

MAINTAINER Sebastian Mandrean <sebastian@urbit.com>

WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

USER root

# Ensure there are enough file descriptors for running Fluentd.
RUN ulimit -n 65536

# Copy the Fluentd configuration file.
COPY td-agent.conf /etc/td-agent/td-agent.conf

# Install dependencies
RUN yum update -y \
    && yum groupinstall -y development \
    && yum install -y sudo ruby-devel \
    
    # Install fluentd
    && curl -sSL https://toolbelt.treasuredata.com/sh/install-redhat-td-agent2.sh | sh \

    # Change the default user and group to root.
    # Needed to allow access to /var/log/docker/... files.
    && sed -i -e "s/USER=td-agent/USER=root/" -e "s/GROUP=td-agent/GROUP=root/" /etc/init.d/td-agent \

    # http://www.fluentd.org/plugins
    && td-agent-gem install --no-document \
        fluent-plugin-kubernetes_metadata_filter:0.26.2 \
        fluent-plugin-aws-elasticsearch-service:0.1.6 \
        fluent-plugin-grok-parser:2.1.0 \
        fluent-plugin-record-modifier:0.5.0 \
        fluent-plugin-mutate_filter:0.2.0 \

    && yum remove -y sudo \
    && rm -rf /opt/td-agent/embedded/lib/ruby/gems/2.1.0/gems/json-1.8.1

EXPOSE 24284
EXPOSE 5140/udp

# Run the Fluentd service.
CMD ["td-agent"]
