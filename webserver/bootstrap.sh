#!/bin/bash

# wire/link the application server and the webserver:
config=/etc/nginx/nginx.conf
cp ${config}.orig $config

# the placeholder %application-server% is written in nginx_ssl.conf
sed -i "s/%application-server%/$CT_PHP5_PORT_9000_TCP_ADDR/" /etc/nginx/nginx.conf

# this is the real entrypoint for the container
/etc/init.d/nginx start
