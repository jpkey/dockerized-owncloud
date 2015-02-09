FROM        jessie:base
MAINTAINER  Johannes Kupser

RUN         apt-get update && apt-get install -y php5-cli \
                                                 php5-gd \
                                                 php5-pgsql \
                                                 php5-sqlite \
                                                 php5-mysqlnd \
                                                 php5-curl \
                                                 php5-intl \
                                                 php5-mcrypt \
                                                 php5-ldap \
                                                 php5-gmp \
                                                 php5-apcu \
                                                 php5-imagick \
                                                 php5-fpm \
                                                 smbclient

ENV         LC_ALL C.UTF-8

ADD         php.ini /etc/php5/fpm/
ADD         php-cli.ini /etc/php5/cli/php.ini
ADD         migrate_db.sh /root/migrate_db.sh
RUN         chmod +x /root/migrate_db.sh
RUN         sed 's/listen = \/var\/run\/php5-fpm.sock/listen = 0.0.0.0:9000/' -i /etc/php5/fpm/pool.d/www.conf 

# container interfaces
EXPOSE      9000

ENTRYPOINT  ["/usr/sbin/php5-fpm" ,"--nodaemonize"]
