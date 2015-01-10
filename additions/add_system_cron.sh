#!/bin/bash

# Addition:
# Configure application container to use system cron for owncloud cron (see http://doc.owncloud.org/server/7.0/admin_manual/configuration/background_jobs.html)
# 
# -> after running this script, go to the admin console of your owncloud installation and check:  
#    (x) Cron
#    Use system's cron service to call the cron.php file every 15 minutes. 
# -> see Readme and usage instructions for manual steps and configuration 

oc_install_dir=/var/www/owncloud


# needed according to owncloud warning if system cron is configured
ln -s $oc_install_dir /owncloud

apt-get install cron -y 
echo "*/15  *  *  *  * www-data php -f /var/www/owncloud/cron.php > /dev/null 2>&1 " >> /etc/crontab 
/etc/init.d/cron restart
