#!/bin/bash

set -e

INIT_DB=${POSTGRES_INIT_DB:-"false"}

LISTEN_ADDRESS=${POSTGRES_LISTEN_ADDRESS:-"*"}
LISTEN_IP=${POSTGRES_LISTEN_IP:-"0.0.0.0/0"}
LISTEN_PORT=${POSTGRES_LISTEN_PORT:-"5432"}

DATA_DIRECTORY=${POSTGRES_DATA_DIRECTORY:-"/var/lib/postgresql/9.4/main"}
BIN_DIRECTORY=${POSTGRES_BIN_DIRECTORY:-"/usr/lib/postgresql/9.4/bin"}
ETC_DIRECTORY=${POSTGRES_ETC_DIRECTORY:-"/etc/postgresql/9.4/main"}

PASSWORD=${POSTGRES_PASSWORD:-"postgres"}
ENCODING=${POSTGRES_ENCODING:-"utf-8"}
REPLICATOR_USER=${POSTGRES_REPLICATOR_USER:-"replicator"}
REPLICATOR_PASSWORD=${POSTGRES_REPLICATOR_PASSWORD:-"replicator"}
PASSWORD=${POSTGRES_PASSWORD:-"postgres"}
REPLICATION_TYPE=${POSTGRES_REPLICATION_TYPE:-"master"}
REPLICATION_NETWORK=${POSTGRES_REPLICATION_NETWORK:-"172.19.0.0/16"}
REPLICATE_FROM_PORT=${POSTGRES_REPLICATE_FROM_PORT:-"5432"}

WAL_LEVEL=${POSTGRES_WAL_LEVEL:-"minimal"}
MAX_WAL_SENDERS=${POSTGRES_MAX_WAL_SENDERS:-"0"}
CHECKPOINT_SEGMENTS=${POSTGRES_CHECKPOINT_SEGMENTS:-"3"}
WAL_KEEP_SEGMENTS=${POSTGRES_WAL_KEEP_SEGMENTS:-"0"}
HOT_STANDBY=${POSTGRES_HOT_STANDBY:-"off"}
ARCHIVE_MODE=${POSTGRESQL_ARCHIVE_MODE:-"off"}
CHANGE_CONFIG=${POSTGRESQL_CHANGE_CONFIG:-"true"}

if [ -e /tmp/postgresql.conf ]; then
    POSTGRESQL_CONF=$(cat /tmp/postgresql.conf)
    echo "${POSTGRESQL_CONF}" > ${ETC_DIRECTORY}/postgresql.conf
fi

if [ -e /tmp/pg_hba.conf ]; then
    PG_HBA_CONF=$(cat /tmp/pg_hba.conf)
    echo "${PG_HBA_CONF}" > ${ETC_DIRECTORY}/pg_hba.conf
fi

if [ -e /tmp/pg_pass_file ]; then
    PG_PASS_FILE_CONF=$(cat /tmp/pg_pass_file)
    echo "${PG_PASS_FILE_CONF}" > ${ETC_DIRECTORY}/pg_pass_file
fi

if [ "$CHANGE_CONFIG" == "true" ];
then
    echo "POSTGRES_LISTEN_ADDRESS ${LISTEN_ADDRESS}"
    echo "POSTGRES_LISTEN_IP ${LISTEN_IP}"
    echo "ENCODING ${ENCODING}"

    echo "WAL_LEVEL ${WAL_LEVEL}"
    echo "MAX_WAL_SENDERS ${MAX_WAL_SENDERS}"
    echo "CHECKPOINT_SEGMENTS ${CHECKPOINT_SEGMENTS}"
    echo "WAL_KEEP_SEGMENTS ${WAL_KEEP_SEGMENTS}"
    echo "HOT_STANDBY" ${HOT_STANDBY}

    #port = 5432
    sed -i -e "s/^port =.*$/port = '${LISTEN_PORT}'/" ${ETC_DIRECTORY}/postgresql.conf

    #listen_addresses = 'localhost'
    sed -i -e "s/^#listen_addresses =.*$/listen_addresses = '${LISTEN_ADDRESS}'/" ${ETC_DIRECTORY}/postgresql.conf

    #wal_level = minimal
    sed -i -e "s/^#wal_level =.*$/wal_level = ${WAL_LEVEL}/" ${ETC_DIRECTORY}/postgresql.conf

    #max_wal_senders = 0
    sed -i -e "s/^#max_wal_senders =.*$/max_wal_senders = ${MAX_WAL_SENDERS}/" ${ETC_DIRECTORY}/postgresql.conf

    #checkpoint_segments = 3
    sed -i -e "s/^#checkpoint_segments =.*$/checkpoint_segments = ${CHECKPOINT_SEGMENTS}/" ${ETC_DIRECTORY}/postgresql.conf

    #wal_keep_segments = 0
    sed -i -e "s/^#wal_keep_segments =.*$/wal_keep_segments = ${WAL_KEEP_SEGMENTS}/" ${ETC_DIRECTORY}/postgresql.conf

    #hot_standby = off
    sed -i -e "s/^#hot_standby =.*$/hot_standby = ${HOT_STANDBY}/" ${ETC_DIRECTORY}/postgresql.conf

    #archive_mode = off
    sed -i -e "s/^#archive_mode =.*$/archive_mode = ${ARCHIVE_MODE}/" ${ETC_DIRECTORY}/postgresql.conf

    #host_name:port:database:username:password
    echo "*:*:*:postgres:${PASSWORD}" >> ${ETC_DIRECTORY}/pg_pass_file
    echo "*:*:*:${REPLICATOR_USER}:${REPLICATOR_PASSWORD}" >> ${ETC_DIRECTORY}/pg_pass_file

    echo "host all all      ::1/128      md5" >> ${ETC_DIRECTORY}/pg_hba.conf
    echo "host all all ${LISTEN_IP} md5" >> ${ETC_DIRECTORY}/pg_hba.conf

    if [ -n "$REPLICATION_NETWORK" ]
    then
        echo "host    replication             ${REPLICATOR_USER}             ${REPLICATION_NETWORK}                 md5" >> ${ETC_DIRECTORY}/pg_hba.conf
    fi

    if [ "$POSTGRES_REPLICATION_TYPE" == "replication" ];
    then
        rm -rf ${DATA_DIRECTORY}/*
        pg_basebackup -D ${DATA_DIRECTORY}/ -h ${POSTGRES_REPLICATE_FROM_IP} -w -p ${REPLICATE_FROM_PORT} -U replicator -Fp --xlog-method=stream
        chown -R postgres:postgres ${DATA_DIRECTORY}
    fi

    if [ "$POSTGRES_REPLICATION_TYPE" == "slave" ];
    then
        rm -rf ${DATA_DIRECTORY}/*
        pg_basebackup -h ${POSTGRES_REPLICATE_FROM_IP} -p ${POSTGRES_REPLICATE_FROM_PORT} -R -D ${DATA_DIRECTORY}/ -U replicator -v -P

        echo "standby_mode = 'on'" >> ${DATA_DIRECTORY}/recovery.conf
        echo "primary_conninfo = 'host=${POSTGRES_REPLICATE_FROM_IP} port=${REPLICATE_FROM_PORT} user=replicator password=${REPLICATOR_PASSWORD} sslmode=require'" >> ${DATA_DIRECTORY}/recovery.conf
        echo "trigger_file = '/tmp/postgresql.trigger'" >> ${DATA_DIRECTORY}/recovery.conf

        chown -R postgres:postgres ${DATA_DIRECTORY}
        chmod -R 0700 ${DATA_DIRECTORY}
    fi

    #&& [ "$(ls -A /var/lib/postgresql/9.4/main/)" ]

    if [ "$INIT_DB" == "true" ];
    then
        echo "Initialize Postgresql database"

        rm -rf ${DATA_DIRECTORY}/*

        echo "${PASSWORD}" > /tmp/passwdpostgres
        chown postgres:postgres /tmp/passwdpostgres

        chown -R postgres:postgres ${DATA_DIRECTORY}
        gosu postgres \
            ${BIN_DIRECTORY}/initdb \
            --pgdata=${DATA_DIRECTORY} \
            --username=postgres \
            --pwfile=/tmp/passwdpostgres \
            --encoding=${ENCODING}

        rm /tmp/passwdpostgres

        chown -R postgres:postgres ${DATA_DIRECTORY}
        chmod -R 0700 ${DATA_DIRECTORY}
        service postgresql start >/dev/null 2>&1

        gosu postgres psql -c "ALTER USER postgres PASSWORD '${PASSWORD}';"
        gosu postgres psql -c "CREATE EXTENSION adminpack;"
        gosu postgres psql -c "CREATE USER ${REPLICATOR_USER} REPLICATION LOGIN ENCRYPTED PASSWORD '${REPLICATOR_PASSWORD}';"

        gosu postgres psql -f /tmp/sql/insert_lock.sql template1
        gosu postgres psql -f /tmp/sql/pgpool-recovery/pgpool_recovery--1.1.sql template1

        if [ -n "$POSTGRES_ADDUSER" ];
        then
            gosu postgres psql -c "CREATE USER ${POSTGRES_ADDUSER} WITH PASSWORD '${POSTGRES_ADDPASSWORD}';"
            gosu postgres psql -c "CREATE DATABASE ${POSTGRES_ADDUSER} OWNER ${POSTGRES_ADDUSER};"
        fi

        service postgresql stop >/dev/null 2>&1
    fi

    chown -R postgres:postgres ${DATA_DIRECTORY}
    chmod -R 0700 ${DATA_DIRECTORY}
fi

#gosu postgres /usr/lib/postgresql/9.4/bin/postgres --config-file=/etc/postgresql/9.4/main/postgresql.conf $@

exec "$@"
