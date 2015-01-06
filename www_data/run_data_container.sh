#!/bin/bash

docker run -d --restart always -t --name ct_www_data -v $OC_INSTALL_DIR:/var/www/owncloud -v $OC_DATA_DIR:/var/owncloud-data -v $OC_SHARE:/var/owncloud-external $SHARE_PICTURES $SHARE_DEV $SHARE_DOCS busybox:latest
