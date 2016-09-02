#!/bin/bash

envsubst < /config/ims.tpl.conf > /config/ims.conf
logstash -f /config/ims.conf