#!/bin/bash

# owncloud installation variables #
export OC_PARENT_DIR=/home/$USER/bin
export OC_INSTALL_DIR=/home/$USER/bin/owncloud

export OC_DATA_DIR=/home/$USER/owncloud-data
export OC_SHARE=/home/$USER/owncloud-external

# additional optional shares which can be set if needed
# if you don't want to mount more from your host, leave these variables empty,
# e.g.: SHARE_PICTURES=
# see: www_data/run_data_container.sh
export SHARE_PICTURES=
export SHARE_DEV="-v /home/$USER/dev:/var/dev:ro" 
export SHARE_DOCS=

export POSTGRES_PASSWORD=topsecret
