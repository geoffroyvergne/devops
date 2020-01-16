# Container MESOS-SLAVE from mesos

FROM mesos

MAINTAINER Geoffroy Vergne "geoffroy.vergne@gmail.com"

RUN mkdir -p /var/lib/mesos/slave
#RUN mkdir -p /run/systemd/system

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

#COPY mesos_executors.slice  /run/systemd/system

ENTRYPOINT ["/docker-entrypoint.sh"]