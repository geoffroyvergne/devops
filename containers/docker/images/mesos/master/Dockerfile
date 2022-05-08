# Container MESOS-MASTER from mesos

FROM mesos

MAINTAINER Geoffroy Vergne "geoffroy.vergne@gmail.com"

RUN mkdir -p /var/lib/mesos/master

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]