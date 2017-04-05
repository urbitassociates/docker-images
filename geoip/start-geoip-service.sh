#!/usr/bin/env sh

echo "UserId ${MAXMIND_USER_ID}">/usr/local/etc/GeoIP.conf;
echo "LicenseKey ${MAXMIND_LICENSE_KEY}">> /usr/local/etc/GeoIP.conf;
echo "ProductIds GeoIP2-City GeoIP2-Country">> /usr/local/etc/GeoIP.conf;

nohup /usr/local/openresty/bin/openresty  > /dev/null 2>&1 &
# It will take some seconds before the service is accessible
/usr/local/bin/geoipupdate && /go/bin/geoip-service -db=/usr/local/share/GeoIP/GeoIP2-City.mmdb -listen=':5000'
