FROM alpine:3.4

MAINTAINER Simon Forsman <simon@urb-it.com>
ENV REFRESHED_AT 20160823

ENV S3FS_VERSION 1.79
RUN apk --update --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/community/ add \
    fuse \
    alpine-sdk \
    linux-pam \
    automake \
    autoconf \
    libxml2-dev \
    shadow \
    fuse-dev \
    curl-dev \
    vsftpd \
    && wget -qO- https://github.com/s3fs-fuse/s3fs-fuse/archive/v${S3FS_VERSION}.tar.gz|tar xz \
    && cd s3fs-fuse-${S3FS_VERSION} \
    && ./autogen.sh \
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && rm -rf /var/cache/apk/*

RUN ln -sf /dev/stdout /var/log/vsftpd.log

COPY fuse.conf /etc/fuse.conf
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ssl.conf /etc/vsftpd/ssl.conf
COPY init.sh /init.sh
RUN chmod +x /init.sh
RUN addgroup ftpuser

CMD /init.sh && s3fs ${VSFTP_S3_BUCKET}:/ ${VSFTP_S3_MOUNTPOINT} -o endpoint=${VSFTP_S3_REGION} -o allow_other -o umask=0002 && vsftpd /etc/vsftpd/vsftpd.conf
