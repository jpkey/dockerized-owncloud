#!/bin/bash

#
# -> as we want the have kind of statelessness containers, we don't need save additions, we just want to execute the script once and get a clean state afterwards  
#

if [ $# -lt 2 ]
then
    echo "Usage : $0 needs two arguments, first: the script to install and second: the container name, where to install the addition" 
    exit
fi


addition=$1
ct=$2

cat $addition | docker exec -i $ct sh -c 'cat > /var/temp_addition.sh'
echo "script added to $ct:/var/temp_addition.sh"

docker exec -i $ct sh -c 'chmod +x /var/temp_addition.sh'
echo "script is now executable"

docker exec -i $ct sh -c './var/temp_addition.sh'
echo "script executed"

docker exec -i $ct sh -c 'rm /var/temp_addition.sh'
echo "addition removed"

