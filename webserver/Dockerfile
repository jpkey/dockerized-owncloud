FROM        jessie:base
MAINTAINER  Johannes Kupser

# Info
# nginx_ssl.conf is configured with 
#    - hardcoded ssl paths to /root/ssl/server.[key|cert]

RUN         apt-get update && apt-get install -y smbclient nginx 
ENV         LC_ALL C.UTF-8

# to get dynamic hostname replacement for linked php application server, we need the original nginx.conf file
# see bootstrap.sh -> docker does host resolving for linked containers with entries in /etc/hosts
ADD         nginx_ssl.conf /etc/nginx/nginx.conf
ADD         nginx_ssl.conf /etc/nginx/nginx.conf.orig
ADD         certs/server.key /root/ssl/server.key
ADD         certs/server.crt /root/ssl/server.crt

# container interfaces only internal visibility
EXPOSE      80
EXPOSE      443

ADD         bootstrap.sh /usr/bin/bootstrap.sh
RUN         chmod +x /usr/bin/bootstrap.sh
ENTRYPOINT  ["bootstrap.sh"]

