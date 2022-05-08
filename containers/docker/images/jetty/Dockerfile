# Container Jetty from alpine

FROM gvergne/alpine:latest

MAINTAINER Geoffroy Vergne <geoffroy.vergne@gmail.com>

RUN apk add --update wget openjdk8-jre curl && rm -rf /var/cache/apk/*

RUN mkdir -p /opt/jetty

RUN addgroup -S jetty && adduser -D -S -H -G jetty jetty && rm -rf /etc/group- /etc/passwd- /etc/shadow-

RUN cd $HOME && curl -O http://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.3.10.v20160621/jetty-distribution-9.3.10.v20160621.tar.gz

RUN cd $HOME && tar zxf $HOME/jetty-distribution-9.3.10.v20160621.tar.gz \
    && mv ./jetty-distribution-9.3.10.v20160621/* /opt/jetty \
    && rm $HOME/jetty-distribution-9.3.10.v20160621.tar.gz

ENV JETTY_HOME /opt/jetty
ENV PATH $JETTY_HOME/bin:$PATH
RUN mkdir -p "$JETTY_HOME"
WORKDIR $JETTY_HOME

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh", "java","-jar","start.jar"]
