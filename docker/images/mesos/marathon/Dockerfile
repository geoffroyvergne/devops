# Mesos Marathoncontainer image

FROM mesos-ubuntu

MAINTAINER Geoffroy Vergne "geoffroy.vergne@gmail.com"

ADD http://downloads.mesosphere.io/marathon/v1.1.1/marathon-1.1.1.tgz /tmp/marathon.tgz
RUN mkdir -p /opt/marathon && tar xzf /tmp/marathon.tgz -C /opt/marathon --strip=1 && rm -f /tmp/marathon.tgz

ENTRYPOINT ["/opt/marathon/bin/start"]
