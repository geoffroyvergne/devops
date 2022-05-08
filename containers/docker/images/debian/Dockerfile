# Container debian base from Debian Jessie

FROM debian:jessie

MAINTAINER Geoffroy Vergne <geoffroy.vergne@gmail.com>

RUN echo "deb http://ftp.de.debian.org/debian jessie-backports main" >> /etc/apt/sources.list

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
