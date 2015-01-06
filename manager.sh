#!/bin/bash


if [ $# -lt 1 ]
then
    echo "Usage : $0 help "
    exit
fi

case "$1" in
    'status')
        echo "current status"
        docker ps -a
        ;;
    'start')
        echo "Starting containers"
        docker start ct_www_data owncloud-postgres ct_php5 ct_webserver
        ;;
    'stop')
        echo "Stopping containers"
        docker stop ct_www_data owncloud-postgres ct_php5 ct_webserver
        ;;
    'rm')
        echo "removing containers"
        docker rm  ct_www_data owncloud-postgres-data owncloud-postgres ct_php5 ct_webserver
        ;;
    'rmi')
        echo "removing images"
        docker rmi owncloud:nginx owncloud:php5 jessie:base 
        echo "now you can run install scripts again"
        ;;
    'help')
        echo "usage of $0: [start|stop|rm|rmi|status]" 
        ;;
    *) echo "$0 doesn't know $1 as argument"
    ;;
esac
