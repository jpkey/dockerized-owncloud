#!/bin/bash

if [ $# -lt 1 ]
then
    echo "Usage : $0 </path/to/your/backup/destination>"
    exit
fi

destination=$1

if [ ! -d "$destination" ]; then
    echo "$destination path does not exist"
    exit -1
fi

#
# --> we use docker to create a compressed tar archive, even if you could also backup the ownlcoud install directory of your host machine
#

# backup owncloud install directory #
# don't replace date function in docker run commands!
today=$(date +"%d-%m-%Y")
docker run --rm --volumes-from ct_www_data -v $destination:/backup debian:jessie tar -zcvf /backup/owncloud-install-dir-$(date +"%d-%m-%Y").tar.gz -C /var/www/ owncloud

# backup database #
docker run -d --name ct_db_backup --volumes-from owncloud-postgres -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD -v $destination:/backup postgres postgres
# we need some time to startup postgres application server...
sleep 5
docker exec ct_db_backup pg_dump postgres -h localhost -U postgres -b -E utf8 -f /backup/owncloud-sql-dump-$(date +"%d-%m-%Y").bak

docker stop ct_db_backup
docker rm ct_db_backup

# check #
check=1
if [ ! -f "${destination}/owncloud-install-dir-${today}.tar.gz" ] 
then 
    echo "owncloud backup went wrong..."
    check=0
fi

chown $USER:$USER ${destination}/owncloud-install-dir-${today}.tar.gz

if [ ! -f "${destination}/owncloud-sql-dump-${today}.bak" ] 
then 
    echo "database backup went wrong..."
    check=0
fi

chown $USER:$USER ${destination}/owncloud-sql-dump-${today}.bak

if [ $check == 1 ] 
then
    echo "backup script finished successfully"
else
    echo "something went wrong, check your configuration and output files"
fi
