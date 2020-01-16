# Container MESOS from gvergne/debian-server:latest

FROM gvergne/debian-server:latest

MAINTAINER Geoffroy Vergne "geoffroy.vergne@gmail.com"

#Install docker-engine
RUN apt-get update && \
  apt-get -y install apt-transport-https ca-certificates && \
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
  echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list && \
  apt-get update && \
  apt-get -y install docker-engine

RUN apt-get update -y && \
    apt-get install -y \
    openjdk-8-jre-headless \
    libsvn1 \
    libsasl2-modules \
    curl

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd $HOME && curl -O http://repos.mesosphere.com/debian/pool/main/m/mesos/mesos_0.28.2-2.0.27.debian81_amd64.deb
#RUN cd $HOME && curl -O http://repos.mesosphere.com/debian/pool/main/m/mesos/mesos_0.24.2-2.0.17.debian81_amd64.deb

RUN cd $HOME && \
    dpkg -i mesos_0.28.2-2.0.27.debian81_amd64.deb && \
    rm mesos_0.28.2-2.0.27.debian81_amd64.deb

RUN systemctl disable mesos-master
RUN systemctl disable mesos-slave

RUN mkdir -p /var/log/mesos
RUN mkdir -p /data/db/mesos

