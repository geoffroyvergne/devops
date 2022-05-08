# Container Logstash from debian-server

FROM gvergne/alpine:latest

MAINTAINER Geoffroy Vergne <geoffroy.vergne@gmail.com>

RUN apk add --update wget openjdk8-jre curl && rm -rf /var/cache/apk/*

RUN mkdir -p /opt/logstash

RUN cd $HOME && curl -O https://download.elastic.co/logstash/logstash/logstash-2.4.0.tar.gz

RUN cd $HOME && tar zxf $HOME/logstash-2.4.0.tar.gz \
    && mv ./logstash-2.4.0/* /opt/logstash \
    && rm $HOME/logstash-2.4.0.tar.gz