#!/bin/bash

# perspective: within container

chmod +x /var/www/owncloud/occ
# usage: db:convert-type [--port="..."] [--password="..."] [--clear-schema] [--all-apps] type username hostname database
#

#
# --> we need to be able to run binary as user www-data, even if we have no login (see /etc/passwd)
chsh -s /bin/bash www-data

# --> we need to run convert script as the user who is running the php service: www-data 
su -c '/var/www/owncloud/occ db:convert-type --port="5432" --password="topsecret" pgsql postgres postgres postgres' -l -- www-data

