#!/bin/bash

# usage:
# if you want to add more trusted hosts to the owncloud config, you have to increment the array keys in the configuration file
# the first entry is made by owncloud installation wizard, which gives us array ( 0 => 'some.host',) so we need to add for example
# 1 => 'some.ip.address', and if we add another trusted host, we have to add: 2 => 'my.special.host'
# --> with the third parameter, you specifiy the key number we add to the php configuration array

if [ $# -lt 3 ]
then
    echo "Usage : $0 needs the ip address followed by the device and a counter,e.g.: $0 10.10.10.10 wlan0 1"
    exit
fi

ip=$1
device=$2
key=$3

echo "dropping and setting iptables rule for device $device"

sudo iptables -t nat -D PREROUTING -i $device -p tcp --dport 443 -j DNAT --to 0.0.0.0:443
sudo iptables -t nat -A PREROUTING -i $device -p tcp --dport 443 -j DNAT --to 0.0.0.0:443

echo "allow $ip as trusted host in owncloud"

sudo sed -i "/0.0.0.0',/a     $key => '$ip'," $OC_INSTALL_DIR/config/config.php
