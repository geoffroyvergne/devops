#!/bin/bash

set -e

HAPROXY_ETC_DIR="/etc/haproxy/haproxy.cfg"
cp /etc/haproxy/haproxy-base.cfg /etc/haproxy/haproxy.cfg

if [ -n "$HAPROXY_STATS_AUTH" ]
then
sed -i -e "s/stats auth admin:admin/stats auth $HAPROXY_STATS_AUTH/" -i ${HAPROXY_ETC_DIR}
fi

if [ -n "$HAPROXY_MODE" ]
then
sed -i -e "s/mode    http/mode    $HAPROXY_MODE/" -i ${HAPROXY_ETC_DIR}
fi

if [ -n "$HAPROXY_OVERRIDE_CONF" ]; then
    echo "HAPROXY_OVERRIDE_CONF : "$HAPROXY_OVERRIDE_CONF
    echo "$HAPROXY_OVERRIDE_CONF" >> ${HAPROXY_ETC_DIR}
fi

if [ -e /tmp/override.cfg ]; then
    OVERRIDE_CONF=$(cat /tmp/override.cfg)
    echo "OVERRIDE_CONF : ${OVERRIDE_CONF}"

    echo "${OVERRIDE_CONF}" >> ${HAPROXY_ETC_DIR}
fi

if [ -e /tmp/default.cfg ]; then
    DEFAULT_CONF=$(cat /tmp/default.cfg)
    echo "${DEFAULT_CONF}" > ${HAPROXY_ETC_DIR}
fi

exec "$@"
