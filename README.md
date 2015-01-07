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

