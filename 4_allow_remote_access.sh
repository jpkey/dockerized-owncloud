#!/bin/bash

if [ $# -lt 2 ]
then
    echo "Usage : $0 needs the ip address followed by the device,e.g.: $0 10.10.10.10 wlan0"
    exit
fi

ip=$1
device=$2
echo "dropping and setting iptables rule for device $device"

sudo iptables -t nat -D PREROUTING -i $device -p tcp --dport 443 -j DNAT --to 0.0.0.0:443
sudo iptables -t nat -A PREROUTING -i $device -p tcp --dport 443 -j DNAT --to 0.0.0.0:443

echo "allow $ip as trusted host in owncloud"

sudo sed -i "/0.0.0.0',/a     1 => '$ip'," $OC_INSTALL_DIR/config/config.php
