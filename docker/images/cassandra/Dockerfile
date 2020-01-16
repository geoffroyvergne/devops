# Container Cassandra from debian

FROM gvergne/debian:latest

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    openjdk-8-jdk \
    apt-transport-https curl wget

RUN apt-get install -y python

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 514A2AD631A57A16DD0047EC749D6EEC0353B12C
RUN echo 'deb http://www.apache.org/dist/cassandra/debian 37x main' >> /etc/apt/sources.list.d/cassandra.list

RUN apt-get update \
	&& apt-get install -y cassandra \
	&& rm -rf /var/lib/apt/lists/*

ENV CASSANDRA_CONFIG /etc/cassandra

COPY conf/cassandra.yaml /etc/cassandra/cassandra.yaml
COPY conf/cassandra-env.sh /etc/cassandra/cassandra-env.sh
COPY conf/cassandra-rackdc.properties /etc/cassandra/cassandra-rackdc.properties

RUN mkdir -p /var/lib/cassandra/data
RUN chown -R cassandra:cassandra /var/lib/cassandra

RUN mkdir -p /usr/share/cassandra/logs
RUN chown -R cassandra:cassandra /etc/cassandra
RUN chown -R cassandra:cassandra /usr/share/cassandra

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh", "cassandra", "-f"]
