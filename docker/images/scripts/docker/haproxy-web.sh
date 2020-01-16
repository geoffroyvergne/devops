#!/usr/bin/env bash

DOCKER_DIR="/mnt/dev/docker"

#if [ "$(docker images | grep haproxy)" ];
#then
#echo "haproxy image exists"
#else
#echo "haproxy image doesnt exists"
#docker rmi $(docker images -q -f dangling=true)
#docker build -t haproxy ${DOCKER_DIR}/haproxy
#fi

if [ "$(docker ps -a -f status=exited | grep haproxy-web-container)" ];
then
    echo "start haproxy-web container"
    docker start haproxy-web-container
fi

if [ "$(docker ps -a | grep haproxy-web-container)" ];
then
    echo "haproxy-web container already exists"
else
    echo "create haproxy-web container"

read -d '' OVERRIDE_CONF << EOF
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

    acl is_jetty hdr_end(host) -i jetty.debianserver.com
    use_backend jetty if is_jetty

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

backend jetty
    balance roundrobin
    cookie JSESSIONID prefix
    server jetty1 192.168.56.22:8181 cookie A check
EOF

docker run -d \
--name haproxy-web-container \
-e HAPROXY_STATS_AUTH="admin:lol" \
-e HAPROXY_OVERRIDE_CONF="$OVERRIDE_CONF" \
-e HAPROXY_MODE="http" \
-p 80:80 -p 443:443 \
gvergne/haproxy:latest
fi

docker ps | grep haproxy-web-container
