#!/bin/bash

NGINX_ETC_DIR="/etc/nginx/conf.d/default.conf"
CHANGE_CONFIG=${NGINX_CHANGE_CONFIG:-"true"}

cp /tmp/default-base.conf /etc/nginx/conf.d/default.conf

if [ -e /tmp/override.conf ]; then
    OVERRIDE_CONF=$(cat /tmp/override.conf)
    echo "OVERRIDE_CONF : ${OVERRIDE_CONF}"

    sed -i "$ s/.$//" ${NGINX_ETC_DIR}
    echo "${OVERRIDE_CONF}" >> ${NGINX_ETC_DIR}
    echo "}" >> ${NGINX_ETC_DIR}
fi

echo "CHANGE_CONFIG : $CHANGE_CONFIG"

if [ -e /tmp/default.conf ]; then
    DEFAULT_CONF=$(cat /tmp/default.conf)
    echo "${DEFAULT_CONF}" > ${NGINX_ETC_DIR}
fi

if [ "$CHANGE_CONFIG" == "true" ];
then
    PORT=${NGINX_PORT:-"80"}
    AUTO_INDEX=${NGINX_AUTO_INDEX:-"off"}
    INDEX=${NGINX_INDEX:-"index index.html index.htm"}
    SERVER_NAME=${NGINX_SERVER_NAME:-"localhost"}

    echo "NGINX_PORT : ${PORT}"
    sed -i -e "s/listen   80;/listen   ${PORT};/" -i ${NGINX_ETC_DIR}
    sed -i -e "s/80 default_server/${PORT} default_server/" -i ${NGINX_ETC_DIR}

    echo "NGINX_AUTO_INDEX : ${AUTO_INDEX}"
    sed -i -e "s/autoindex off;/autoindex ${AUTO_INDEX};/" -i ${NGINX_ETC_DIR}

    echo "NGINX_INDEX : ${INDEX}"
    sed -i -e "s/index test.html index.htm;/index ${INDEX};/" -i ${NGINX_ETC_DIR}

    echo "NGINX_SERVER_NAME : ${SERVER_NAME}"
    sed -i -e "s/server_name localhost;/server_name ${SERVER_NAME};/" -i ${NGINX_ETC_DIR}

    if [ -n "$NGINX_ALLOW_STATUS_PING" ]
    then
        echo "NGINX_ALLOW_STATUS_PING : ${NGINX_ALLOW_STATUS_PING}"
        sed -i -e "s/allow 0.0.0.0; #StatusPing/allow ${NGINX_ALLOW_STATUS_PING}; #StatusPing/" -i ${NGINX_ETC_DIR}
    fi

    if [ -n "$NGINX_PHP_FPM_BIND" ]
    then
        echo "NGINX_PHP_FPM_BIND : ${NGINX_PHP_FPM_BIND}"
        sed -i -e "s/fastcgi_pass php-fpm-container:9000;/fastcgi_pass ${NGINX_PHP_FPM_BIND};/" -i ${NGINX_ETC_DIR}
    fi

    if [ -n "$NGINX_OVERRIDE_CONF" ]
    then
        echo "NGINX_OVERRIDE_CONF : ${NGINX_OVERRIDE_CONF}"

        sed -i "$ s/.$//" ${NGINX_ETC_DIR}
        echo "${NGINX_OVERRIDE_CONF}" >> ${NGINX_ETC_DIR}
    fi

    #cat ${NGINX_ETC_DIR}
fi

exec "$@"
