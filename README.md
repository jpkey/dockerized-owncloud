dockerized-owncloud
===================

#features
- separation of concerns: only one task per container
  - webserver container (nginx)
  - application server container (php5-fgm)
  - database server container (postgres)
  - volume/data container
- automated owncloud installation 
- individual owncloud configuration using install wizard
- automated build and container deployment
- automated start on machine reboot
- mount external storage in owncloud: enable external storage plugin then go to admin console and add: /var/owncloud-external (this is a mount point to /home/$USER/owncloud-external)
    - especially for home folder files, see: www_data/run_* script
    - user must be in group www-data
- allow trusted hosts to enable remote access from the host machine (see script 4_*)
- automated owncloud backups and database dumps
- possibility to automatically add and run additions (see usage instructions for details)
 

# requirements
- docker >= 1.4.1
- wget
- $USER must be in docker group (sudo usermod -a -G docker $USER and then logout and login again)
- ssl certificate and key stored in ./webserver/certs/server.[key|crt] -> use your favorite search engine to get your ssl certificates


# usage instructions
Some scripts contain sudo commands, therefore I recommend using some sudo command in your current shell session to avoid password inputs during the deployment.

1. source 0_configure.sh
2. run the scripts 1 and 2 
3. follow owncloud wizard
  1. go to https://0.0.0.0/owncloud
  2. add admin user credentials
  3. open storage and database menu
    - storage: /var/owncloud-data
    - database: sqlite
4. run the script 3
5. refresh your browser 
6. **optional** run script 4 if you want to enable remote access from your machine or smartphone
  - the scipt adds an ip address entry in owncloud/config/config.php and enables iptables forwarding
  - look into the 4_allow_remote_access.sh script for further usage details
  
- try the tiny **container manager**: ./manger.sh help
  - ./manager stop      -> stops necessary containers
  - ./manager start     -> start necessary containers
  - ./manager rm        -> removes necessary containers from machine
  - ./manager rmi       -> removes necessary images from machine
  - ./manager status    -> runs docker ps -a for you

- **backups**
  - backup script does not backup your user data from owncloud, but the owncloud installation and database
  - source 0_configure.sh
  - usage: 5_backup.sh </path/to/your/backup/destination>
    - creates compressed archive of your owncloud installation (the docker way)
    - creates a sql dump of the database

- **current additions** 
    - configure php application server to use system cron instead of ajax cron upon user request
      - call script ./6_install_additions.sh additions/add_system_cron.sh ct_php5
      - run: source 0_configure.sh
      - run: sudo sed -i "/CONFIG = array (/a 'overwritewebroot' => '/owncloud'," $OC_INSTALL_DIR/config/config.php
      - now you can go to the admin console of your owncloud installation and check:  
         (x) Cron
         Use system's cron service to call the cron.php file every 15 minutes. 
      - refresh the page and you're good to go

  - additions are more specific to your installation therefore you have to adjust variables and paths within your additions as they are executed within a container scope, but you can of course use the container environment variables in the additions scripts
  - call script ./6_install_additions.sh additions/my_addition.sh container_[name|id]
  


# owncloud
- owncloud directory in container: /var/www/owncloud
- owncloud data directory in container: /var/owncloud-data
- drop location/ public share mapped to variable OC_SHARE within container: /var/owncloud-external



# sources/inspiration
- https://github.com/jchaney/owncloud
- http://www.herr-norbert.de/2014/10/04/docker-owncloud/


#TODO
- collect log files from containers
- check access logs

