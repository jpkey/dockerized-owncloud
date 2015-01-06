FROM        debian:jessie
MAINTAINER  Johannes Kupser

RUN         apt-get update && apt-get install -y locales vim

RUN         dpkg-reconfigure locales && \
            locale-gen C.UTF-8 && \
            /usr/sbin/update-locale LANG=C.UTF-8

ENV         LC_ALL C.UTF-8
