FROM openresty/openresty:alpine

MAINTAINER Jonas Odencrants <jonas.odencrants@urbit.com>


# Copy files & set permissions
COPY nginx.conf /usr/local/openresty/nginx/conf/
COPY init-d-nginx /etc/init.d/nginx

RUN mkdir -p /usr/local/api-gateway/nginx/conf.d && \
    mkdir -p /usr/local/api-gateway/nginx/upstream && \
    chmod +x /etc/init.d/nginx

# Install dependencies
RUN apk --no-cache --update add \
    curl \
    perl \
&& apk --no-cache del \
    wget

# Install opm packages
RUN opm install chunpu/shim
RUN opm install pintsized/lua-resty-http
# Remove dependencies & clean up
RUN apk --no-cache del \
    wget  \
&& rm -rf /var/cache/apk/* /tmp/*

WORKDIR /usr/local/api-gateway

EXPOSE 80 443
