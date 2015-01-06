#!/bin/bash

# POSTGRES_PASSWORD is needed to migrate the sqlite database to postgres sql

docker run -d --restart always --name ct_php5 -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD --volumes-from ct_www_data --link owncloud-postgres:postgres -t owncloud:php5 
