#!/bin/bash

CHANGE_CONFIG=${ZOOKEEPER_CHANGE_CONFIG:-"true"}
ZOOKEEPER_ETC_DIR="/opt/zookeeper/conf/zoo.cfg"

cp /tmp/zoo-base.cfg ${ZOOKEEPER_ETC_DIR}

if [ -e /tmp/override.conf ]; then
    OVERRIDE_CONF=$(cat /tmp/override.conf)
    echo "OVERRIDE_CONF : ${OVERRIDE_CONF}"

    echo "${OVERRIDE_CONF}" >> ${ZOOKEEPER_ETC_DIR}
fi

if [ -e /tmp/default.cfg ]; then
    DEFAULT_CONF=$(cat /tmp/default.cfg)
    echo "${DEFAULT_CONF}" > ${ZOOKEEPER_ETC_DIR}
fi

if [ "$CHANGE_CONFIG" == "true" ]; then
    TICK_TIME=${ZOOKEEPER_TICKTIME:-"2000"}
    CLIENT_PORT=${ZOOKEEPER_CLIENT_PORT:-"2181"}
    INIT_LIMIT=${ZOOKEEPER_INIT_LIMIT:-"5"}
    SYNC_LIMIT=${ZOOKEEPER_SYNC_LIMIT:-"2"}

    echo "TICK_TIME : ${TICK_TIME}"
    sed -i -e "s/tickTime=.*$/tickTime=${TICK_TIME}/" -i ${ZOOKEEPER_ETC_DIR}

    echo "CLIENT_PORT : ${CLIENT_PORT}"
    sed -i -e "s/clientPort=.*$/clientPort=${CLIENT_PORT}/" -i ${ZOOKEEPER_ETC_DIR}

    echo "INIT_LIMIT : ${INIT_LIMIT}"
    sed -i -e "s/initLimit=.*$/initLimit=${INIT_LIMIT}/" -i ${ZOOKEEPER_ETC_DIR}

    echo "SYNC_LIMIT : ${SYNC_LIMIT}"
    sed -i -e "s/syncLimit=.*$/syncLimit=${INIT_LIMIT}/" -i ${ZOOKEEPER_ETC_DIR}

    if [ -n "$ZOOKEEPER_OVERRIDE_CONF" ]; then
        echo "ZOOKEEPER_OVERRIDE_CONF : ${ZOOKEEPER_OVERRIDE_CONF}"
        echo "$ZOOKEEPER_OVERRIDE_CONF" >> ${ZOOKEEPER_ETC_DIR}
    fi

fi

exec "$@"
