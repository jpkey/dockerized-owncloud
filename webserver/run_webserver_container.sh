#!/bin/bash

docker run -d --restart always -h webserver -p 443:443 --name ct_webserver --volumes-from ct_www_data --link ct_php5:ct_php5 --link owncloud-postgres:postgres -t owncloud:nginx
