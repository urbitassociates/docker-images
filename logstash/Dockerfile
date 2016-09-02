FROM logstash:2

MAINTAINER Simon Forsman <simon@urb-it.com>

RUN plugin install logstash-output-amazon_es

RUN apt-get update && apt-get install -y --no-install-recommends gettext-base \
	&& rm -rf /var/lib/apt/lists/*

COPY ims.tpl.conf /config/ims.tpl.conf
COPY init.sh /init.sh
RUN chmod +x /init.sh

CMD /init.sh