# Container Keepalived from gvergne/debian-server

FROM gvergne/debian-server:latest

RUN apt-get update -y && \
  apt-get install -y kmod ipvsadm keepalived

RUN echo "net.ipv4.ip_nonlocal_bind = 1" >> /etc/sysctl.conf

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh", "keepalived", "--use-file", "/etc/keepalived/keepalived.conf", "--dont-fork", "--log-console"]
