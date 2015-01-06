#!/bin/bash

# perspective: within container

cd /var/www/owncloud/
chmod +x occ
# usage: db:convert-type [--port="..."] [--password="..."] [--clear-schema] [--all-apps] type username hostname database
#
./occ db:convert-type --port="5432" --password="$POSTGRES_PASSWORD" pgsql postgres postgres postgres
