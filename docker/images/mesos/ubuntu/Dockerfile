FROM ubuntu:14.04

RUN apt-get update && \
  apt-get -y install apt-transport-https ca-certificates && \
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
  echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list && \
  apt-get -y update && \
  apt-get -y install docker-engine

RUN echo "deb http://repos.mesosphere.io/ubuntu trusty main" > /etc/apt/sources.list.d/mesosphere.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF && \
  apt-get -y update && \
  apt-get install -y mesos

RUN apt-get -y update && apt-get install -y software-properties-common python-software-properties && \
  add-apt-repository -y ppa:openjdk-r/ppa && \
  apt-get -y update  && \
  apt-get install -y openjdk-8-jdk-headless && \
  update-java-alternatives -s java-1.8.0-openjdk-amd64

RUN apt-get clean && rm -rf /var/lib/apt/lists/*
