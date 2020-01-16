# Container Elasticsearch from debian-server

FROM gvergne/alpine:latest

MAINTAINER Geoffroy Vergne <geoffroy.vergne@gmail.com>

RUN apk add --update wget openjdk8-jre curl && rm -rf /var/cache/apk/*

RUN addgroup -S elasticsearch && adduser -D -S -H -G elasticsearch elasticsearch && rm -rf /etc/group- /etc/passwd- /etc/shadow-

RUN mkdir -p /etc/elasticsearch
COPY conf/elasticsearch.yml /etc/elasticsearch

RUN mkdir -p /opt/elasticsearch
RUN mkdir -p /var/lib/elasticsearch
RUN mkdir -p /var/log/elasticsearch

RUN chown -R elasticsearch:elasticsearch /opt/elasticsearch
RUN chown -R elasticsearch:elasticsearch /var/lib/elasticsearch
RUN chown -R elasticsearch:elasticsearch /etc/elasticsearch
RUN chown -R elasticsearch:elasticsearch /var/log/elasticsearch

RUN cd $HOME && curl -O https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/2.4.0/elasticsearch-2.4.0.tar.gz

RUN cd $HOME && tar zxf $HOME/elasticsearch-2.4.0.tar.gz \
    && mv ./elasticsearch-2.4.0/* /opt/elasticsearch \
    && rm $HOME/elasticsearch-2.4.0.tar.gz

RUN /opt/elasticsearch/bin/plugin install discovery-multicast
RUN /opt/elasticsearch/bin/plugin install mobz/elasticsearch-head

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
#ENTRYPOINT ["/docker-entrypoint.sh"]
#RUN chown -R elasticsearch:elasticsearch /var/lib/elasticsearch

#CMD["/opt/elasticsearch/bin/elasticsearch", "--bootstrap.mlockall=true", "--path.conf=/etc/elasticsearch", "path.logs=/var/log/elasticsearch", "--path.data=/var/lib/elasticsearch"]
ENTRYPOINT ["/opt/elasticsearch/bin/elasticsearch"]
