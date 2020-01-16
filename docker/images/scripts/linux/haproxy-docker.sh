#!/bin/sh
set -e

### BEGIN INIT INFO
# Provides:		haproxy-docker
# Required-Start: $local_fs $remote_fs
# Required-Stop:  $local_fs $remote_fs
# Should-Start:   $network docker
# Should-Stop:    $network docker
# Default-Start:	2 3 4 5
# Default-Stop:		0 1 6
# Short-Description:	Haproxy docker
### END INIT INFO

#update-rc.d haproxy-docker remove
#update-rc.d haproxy-docker defaults

CONTAINER_NAME="haproxy-container"
IMAGE_NAME="gvergne/haproxy:latest"

OVERRIDE_CONF=$(cat <<EOF
frontend public
    bind *:80
    bind *:443 ssl crt /etc/ssl/xip.io/xip.io.pem

    stats enable
    stats hide-version
    stats refresh 30s
    stats show-node
    stats auth admin:admin
    stats uri /stats

    #redirect scheme https if !{ ssl_fc }
    #http-request redirect code 301 location http://www.%[hdr(host)]%[capture.req.uri] unless { hdr_beg(host) -i www }

    default_backend php
    http-request set-header X-Custom-Host %[req.hdr(Host)]
    http-request set-header X-Custom-Uri %[capture.req.uri]
    http-request set-header X-Custom-Port %[dst_port]
    http-request set-header X-Custom-Path %[path]

    acl is_http dst_port -i 80
    http-request set-header X-Custom-Proto http if is_http
    http-request set-header X-Custom-Enable-Https off if is_http

    acl is_https dst_port -i 443
    http-request set-header X-Custom-Proto https if is_https
    http-request set-header X-Custom-Enable-Https on if is_https

    acl is_jetty-default hdr_end(host) -i jetty-default.debianserver.com
    use_backend jetty-default if is_jetty-default

    acl is_wildfly-jee-base hdr_end(host) -i wildfly-jee-base.debianserver.com
    use_backend wildfly-jee-base if is_wildfly-jee-base

    acl is_php hdr_end(host) -i php.debianserver.com
    acl is_php hdr_end(host) -i www.debianserver.com
    use_backend php if is_php

    acl is_static hdr_end(host) -i static.debianserver.com
    use_backend static if is_static

backend static
    balance roundrobin
    server nginx1 192.168.56.22:81 cookie A check

backend php
    balance roundrobin
    server php1 192.168.56.22:82 cookie A check

backend jetty-default
    balance roundrobin
    cookie JSESSIONID prefix
    server jetty1 192.168.56.22:8181 cookie A check

backend wildfly-jee-base
    balance roundrobin
    cookie JSESSIONID prefix
    server jetty1 192.168.56.22:8081 cookie A check
EOF
)

case "$1" in
    start)
        docker run -d \
            --restart unless-stopped \
            --name ${CONTAINER_NAME} \
            -e HAPROXY_STATS_AUTH="admin:admin" \
            -e HAPROXY_OVERRIDE_CONF="$OVERRIDE_CONF" \
            -e HAPROXY_MODE="http" \
            -p 80:80 -p 443:443 \
            ${IMAGE_NAME}
    exit 0
    ;;

    stop)
        docker rm -f ${CONTAINER_NAME}
    exit 0
	;;

    status)
        docker ps -a | grep ${CONTAINER_NAME}
    exit 0
    ;;
    *)
        echo "Usage: $0 {start|stop|status}"
        exit 1
    ;;
esac

exit 0