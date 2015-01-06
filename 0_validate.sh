#!/bin/bash

echo "did you run:   source 0_configure.sh   first? Otherwise the environment variables won't be set"
echo ""

install=1

if [ -z "$OC_INSTALL_DIR" ]
then
    echo "\$OC_INSTALL_DIR is not set"
    install=0
fi

if [ -z "$OC_PARENT_DIR" ]
then
    echo "\$OC_PARENT_DIR is not set"
    install=0
fi

if [ -z "$OC_DATA_DIR" ]
then
    echo "\$OC_DATA_DIR is not set"
    install=0
fi

if [ -z "$OC_SHARE" ]
then
    echo "\$OC_SHARE is not set"
    install=0
fi

if [ -z "$POSTGRES_PASSWORD" ]
then
    echo "\$POSTGRES_PASSWORD is not set"
    install=0
fi


echo "checking for required files..." 
key=./webserver/certs/server.key
crt=./webserver/certs/server.crt

if [ ! -f "$key" ] 
then 
    echo "$key file is missing"
    install=0
fi

if [ ! -f "$crt" ] 
then 
    echo "$crt file is missing"
    install=0
fi


#check if required tools are installed
echo "checking for required tools"
which docker >/dev/null 2>&1 || { 
  echo "'docker' command is missing" >&2
  install=0
}
which wget >/dev/null 2>&1 || { 
    echo "'wget' command is missing" >&2
    install=0
}

which sudo >/dev/null 2>&1 || { 
    echo "'sudo' command is missing" >&2
    install=0
}

if groups $USER | grep &>/dev/null '\bdocker\b'; then
    echo ""
else
    echo "you're user is not in group docker, see README"
    install=0
fi


# print summary
echo "oc install dir: $OC_INSTALL_DIR"
echo "oc parent dir: $OC_PARENT_DIR" 
echo "oc data dir: $OC_DATA_DIR"
echo "oc share: $OC_SHARE"
echo "postgres password: $POSTGRES_PASSWORD"

echo "your groups:"
groups


echo ""
if [ $install == 1 ]
then
    echo "you're setting seems fine, try to deploy..."
else
    echo "check your configuration!"
fi


