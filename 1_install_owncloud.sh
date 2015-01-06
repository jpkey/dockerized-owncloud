#!/bin/bash

latest=owncloud-latest.tar.bz2

if [ -f "$latest" ] 
then 
    echo "$latest file is already available, please move or delete it and try again"
    exit 
fi


wget http://download.owncloud.org/community/owncloud-latest.tar.bz2

tar xvf $latest -C $OC_PARENT_DIR

sudo rm -f $OC_INSTALL_DIR/config/*.php
mkdir $OC_DATA_DIR $OC_SHARE

sudo chown -R www-data:www-data $OC_INSTALL_DIR $OC_DATA_DIR $OC_SHARE 
