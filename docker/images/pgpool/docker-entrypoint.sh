#!/bin/bash

set -e

ETC_DIRECTORY="/etc/pgpool2"
HBA_BIND_IP=${PGPOOL_HBA_BIND_IP:-"0.0.0.0/0"}
LISTEN_ADDRESS=${PGPOOL_LISTEN_ADDRESS:-"*"}
PCP_LISTEN_ADDRESS=${PGPOOL_PCP_LISTEN_ADDRESS:-"*"}
LISTEN_PORT=${PGPOOL_LISTEN_PORT:-"9999"}
PCP_LISTEN_ADDRESSES=${PGPOOL_PCP_LISTEN_ADDRESSES:-"*"}
PCP_PORT=${PGPOOL_PCP_PORT:-"9898"}
PASSWORD=${POSTGRES_PASSWORD:-"postgres"}
CHANGE_CONFIG=${NGINX_CHANGE_CONFIG:-"true"}

if [ -e /tmp/backends.conf ]; then
    BACKENDS_CONF=$(cat /tmp/backends.conf)
    echo "BACKENDS_CONF : ${BACKENDS_CONF}"

    echo "${BACKENDS_CONF}" >> ${ETC_DIRECTORY}/pgpool.conf
fi

if [ -e /tmp/pgpool.conf ]; then
    PGPOOL_CONF=$(cat /tmp/pgpool.conf)
    echo "${PGPOOL_CONF}" > ${ETC_DIRECTORY}/pgpool.conf
fi

if [ "$CHANGE_CONFIG" == "true" ];
then
    echo "host    all         all         ${HBA_BIND_IP}               md5" >> ${ETC_DIRECTORY}/pool_hba.conf

    cat ${ETC_DIRECTORY}/pool_hba.conf

    #listen_addresses
    sed -i -e "s/^listen_addresses =.*$/listen_addresses = '${LISTEN_ADDRESS}'/" ${ETC_DIRECTORY}/pgpool.conf

    #pcp_listen_addresses
    sed -i -e "s/^pcp_listen_addresses =.*$/pcp_listen_addresses = '${PCP_LISTEN_ADDRESS}'/" ${ETC_DIRECTORY}/pgpool.conf


    #port
    sed -i -e "s/^port =.*$/port = ${LISTEN_PORT}/" ${ETC_DIRECTORY}/pgpool.conf

    #pcp_listen_addresses = '*'
    sed -i -e "s/^pcp_listen_addresses =.*$/pcp_listen_addresses = ${PCP_LISTEN_ADDRESSES}/" ${ETC_DIRECTORY}/pgpool.conf

    #pcp_port = 9898
    sed -i -e "s/^pcp_port =.*$/pcp_port = ${PCP_PORT}/" ${ETC_DIRECTORY}/pgpool.conf

    echo "*:*:*:postgres:${PASSWORD}" >> /etc/postgresql/9.4/main/pg_pass_file

    #if [ -n "$PGPOOL_BACKENDS" ]
    #then
    #    echo "PGPOOL_BACKENDS : $PGPOOL_BACKENDS"
    #    echo "$PGPOOL_BACKENDS" >> ${ETC_DIRECTORY}/pgpool.conf
    #fi

    cp /etc/pgpool2/pool_password /etc/pgpool2/pcp.conf

    #pgpool --dont-detach \
    #--clear --discard-status --clear-oidmaps \
    #--config-file /etc/pgpool2/pgpool.conf \
    #--hba-file /etc/pgpool2/pool_hba.conf \
    #--pcp-file /etc/pgpool2/pcp.conf \
    #--debug $@
fi

exec "$@"
