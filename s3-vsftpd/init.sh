#!/bin/sh

if [ -n ${SSL_CERTIFICATE+x} ]
    then
        mkdir -p /var/cert
        mount tmpfs /var/cert -t tmpfs -o size=16M
        echo -e "$SSL_CERTIFICATE" | sed -e 's/^"//' -e 's/"$//' > /var/cert/vsftpd.pem
        echo "" >> /etc/vsftpd/vsftpd.conf
        cat /etc/vsftpd/ssl.conf >> /etc/vsftpd/vsftpd.conf
        unset SSL_CERTIFICATE
fi
