# Container ZOOKEEPER from gvergne/debian-server:latest

FROM gvergne/alpine:latest

MAINTAINER Geoffroy Vergne "geoffroy.vergne@gmail.com"

RUN apk add --update wget openjdk8-jre curl && rm -rf /var/cache/apk/*

RUN mkdir -p /opt/zookeeper

RUN addgroup -S zookeeper && adduser -D -S -H -G zookeeper jetty && rm -rf /etc/group- /etc/passwd- /etc/shadow-

RUN cd $HOME && curl -O http://www-eu.apache.org/dist/zookeeper/stable/zookeeper-3.4.8.tar.gz

RUN cd $HOME && tar zxf $HOME/zookeeper-3.4.8.tar.gz \
    && mv ./zookeeper-3.4.8/* /opt/zookeeper \
    && rm $HOME/zookeeper-3.4.8.tar.gz

RUN mkdir -p /tmp/zookeeper

COPY conf/zoo.cfg /tmp/zoo-base.cfg

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh", "/opt/zookeeper/bin/zkServer.sh", "start-foreground"]

#CMD ["/opt/zookeeper/bin/zkServer.sh", "start-foreground"]
