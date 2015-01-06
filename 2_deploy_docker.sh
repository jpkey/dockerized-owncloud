#!/bin/bash

if [ ! -d "$OC_INSTALL_DIR" ]; then
    echo "install ownlcoud first"
    exit -1
fi

workdir=$PWD
cd $workdir

# build base image #
cd base
docker build -t jessie:base .

cd $workdir

# run volume data containers #
./www_data/run_data_container.sh

# run postgres containers #
./db/run_db_container.sh

# build and run php application image and container"
cd php5-fpm
docker build -t owncloud:php5 .
./run_fpm_container.sh

# build and run webserver #
cd $workdir
cd webserver
docker build -t owncloud:nginx .
./run_webserver_container.sh

docker ps -a

echo "open https://0.0.0.0/owncloud in your browser and do the most basic setup with /var/owncloud-data as storage folder -> select sqlite!"

