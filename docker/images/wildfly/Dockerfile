# Container WILDFLY from gvergne/alpine:latest

FROM gvergne/alpine:latest

MAINTAINER Geoffroy Vergne "geoffroy.vergne@gmail.com"

RUN apk add --update wget openjdk8-jre curl && rm -rf /var/cache/apk/*

ADD https://github.com/Yelp/dumb-init/releases/download/v1.0.2/dumb-init_1.0.2_amd64 /usr/bin/dumb-init
RUN chmod +x /usr/bin/dumb-init

RUN mkdir -p /opt/jboss/wildfly

ENV WILDFLY_VERSION 10.0.0.Final
ENV WILDFLY_SHA1 c0dd7552c5207b0d116a9c25eb94d10b4f375549
ENV JBOSS_HOME /opt/jboss/wildfly

RUN cd $HOME \
    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
    && mv $HOME/wildfly-$WILDFLY_VERSION/* /opt/jboss/wildfly \
    && rm wildfly-$WILDFLY_VERSION.tar.gz

ADD https://jdbc.postgresql.org/download/postgresql-9.4.1209.jar /tmp

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh", "/opt/jboss/wildfly/bin/standalone.sh"]
