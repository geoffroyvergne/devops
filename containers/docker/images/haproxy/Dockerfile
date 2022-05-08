# Container HAPROXY from gvergne/debian-server

FROM gvergne/alpine:latest

MAINTAINER Geoffroy Vergne <geoffroy.vergne@gmail.com>

RUN apk add --update haproxy && rm -rf /var/cache/apk/*

RUN ln -sf /dev/stdout /var/log/haproxy.log

COPY conf/haproxy.cfg /etc/haproxy/haproxy-base.cfg

RUN mkdir /run/haproxy/
RUN mkdir -p /etc/ssl/xip.io

COPY ssl/* /etc/ssl/xip.io/

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["dumb-init", "/docker-entrypoint.sh", "haproxy", "-f", "/etc/haproxy/haproxy.cfg", "-d"]
