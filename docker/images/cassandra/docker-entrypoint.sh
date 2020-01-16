#!/bin/bash

CASSANDRA_ETC_FILE="/etc/cassandra/cassandra.yaml"
CASSANDRA_RACKDC_FILE="/etc/cassandra/cassandra-rackdc.properties"
CLUSTER_NAME=${CASSANDRA_CLUSTER_NAME:-"cassandra-cluster"}
LISTEN_ADDRESS=${CASSANDRA_LISTEN_ADDRESS:-"$(hostname --ip-address)"}
RPC_ADDRESS=${CASSANDRA_RPC_ADDRESS:-"$(hostname --ip-address)"}
SEEDS=${CASSANDRA_SEEDS:-"$(hostname --ip-address)"}
DC=${CASSANDRA_DC:-"data-center-1"}
RACK=${CASSANDRA_RACK:-"rack-1"}
NUM_TOKENS=${CASSANDRA_NUM_TOKENS:-""}
ENDPOINT_SNITCH=${CASSANDRA_ENDPOINT_SNITCH:-"GossipingPropertyFileSnitch"}
CHANGE_CONFIG=${POSTGRESQL_CHANGE_CONFIG:-"true"}

if [ "$CHANGE_CONFIG" == "true" ];
then
    echo "CASSANDRA_CLUSTER_NAME : "${CLUSTER_NAME}
    sed -i -e "s/^cluster_name:.*$/cluster_name: '${CLUSTER_NAME}'/" ${CASSANDRA_ETC_FILE}

    echo "CASSANDRA_LISTEN_ADDRESS : "${LISTEN_ADDRESS}
    sed -i -e "s/^listen_address:.*$/listen_address: '${LISTEN_ADDRESS}'/" ${CASSANDRA_ETC_FILE}

    #rpc_address: localhost
    echo "CASSANDRA_RPC_ADDRESS : "${RPC_ADDRESS}
    sed -i -e "s/^rpc_address:.*$/rpc_address: '${RPC_ADDRESS}'/" ${CASSANDRA_ETC_FILE}

    echo "CASSANDRA_SEEDS : "${SEEDS}
    sed -i -e "s/seeds:.*$/seeds: '${SEEDS}'/" ${CASSANDRA_ETC_FILE}
    #cat /etc/cassandra/cassandra.yaml | grep seeds

    echo "CASSANDRA_DC : "${DC}
    sed -i -e "s/^dc=.*$/dc=${DC}/" ${CASSANDRA_RACKDC_FILE}

    echo "CASSANDRA_RACK : "${RACK}
    sed -i -e "s/^rack=.*$/rack=${RACK}/" ${CASSANDRA_RACKDC_FILE}

    #if [ -n "$CASSANDRA_ENDPOINT_SNITCH" ]
    #then
    echo "CASSANDRA_ENDPOINT_SNITCH : "${ENDPOINT_SNITCH}
    sed -i -e "s/^endpoint_snitch:.*$/endpoint_snitch: '${ENDPOINT_SNITCH}'/" ${CASSANDRA_ETC_FILE}
    #fi

    #echo "CASSANDRA_NUM_TOKENS : "${NUM_TOKENS}
    #sed -i -e "s/^num_tokens:.*$/num_tokens: '${NUM_TOKENS}'/" ${CASSANDRA_ETC_FILE}
fi

exec "$@"
