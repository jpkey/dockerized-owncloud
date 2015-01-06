#!/bin/bash


#container must only run once (that's why: https://stackoverflow.com/questions/24353387/how-docker-container-volumes-work-even-when-they-arent-running)
docker run -d --name owncloud-postgres-data -v /var/lib/postgresql/data busybox 

docker run -d --restart always --name owncloud-postgres -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD --volumes-from owncloud-postgres-data postgres 


