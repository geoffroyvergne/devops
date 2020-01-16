#!/bin/bash

WILDFLY_HOME="/opt/jboss/wildfly"
STANDALONE_CONFIG="/opt/jboss/wildfly/standalone/configuration/standalone.xml"
PACKAGE_NAME=${WILDFLY_PACKAGE_NAME:-"/tmp/jee-base-ear.ear"}

ADMIN_USERNAME=${WILDFLY_ADMIN_USERNAME:-"admin"}
ADMIN_GROUP=${WILDFLY_ADMIN_GROUP:-"admin"}
ADMIN_PASSWORD=${WILDFLY_ADMIN_PASSWORD:-"admin"}
BIND_IP=${WILDFLY_BIND_IP:-"0.0.0.0"}
BIND_MANAGEMENT_IP=${WILDFLY_BIND_MANAGEMENT_IP:-"0.0.0.0"}

CONFIG_MODE=${WILDFLY_CONFIG_MODE:-"postgresql"}
DATASOURCE_DRIVER_LOCATION=${WILDFLY_DATASOURCE_DRIVER_LOCATION:-"/tmp/postgresql-9.4.1209.jar"}
DATASOURCE_JNDI_NAME=${WILDFLY_DATASOURCE_JNDI_NAME:-"PostgresqlDS"}
DATASOURCE_POOL_NAME=${WILDFLY_DATASOURCE_POOL_NAME:-"PostgresqlDS"}

DATASOURCE_CONNECTION_HOST=${WILDFLY_DATASOURCE_CONNECTION_HOST:-"postgresql-container"}
DATASOURCE_CONNECTION_PORT=${WILDFLY_DATASOURCE_CONNECTION_PORT:-"5432"}
DATASOURCE_CONNECTION_SCHEMA=${WILDFLY_DATASOURCE_CONNECTION_SCHEMA:-"wildfly"}

DATASOURCE_USERNAME=${WILDFLY_DATASOURCE_USERNAME:-"wildfly"}
DATASOURCE_PASSWORD=${WILDFLY_DATASOURCE_PASSWORD:-"wildfly"}

cat>/tmp/script.cli<<EOF

batch

module add \
    --name=org.postgresql \
    --resources=${DATASOURCE_DRIVER_LOCATION} \
    --resource-delimiter=, \
    --dependencies=javax.api,javax.transaction.api

/subsystem=datasources/jdbc-driver=postgresql:add(driver-name=postgresql, \
    driver-module-name=org.postgresql, \
    driver-class-name=org.postgresql.Driver, \
    driver-xa-datasource-class-name=org.postgresql.xa.PGXADataSource)

data-source add \
    --name=PostgresqlDS \
    --driver-name=postgresql \
    --jndi-name=java:jboss/jdbc/PostgresqlDS \
    --user-name=${DATASOURCE_USERNAME} \
    --password=${DATASOURCE_PASSWORD} \
    --valid-connection-checker-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLValidConnectionChecker \
    --exception-sorter-class-name=org.jboss.jca.adapters.jdbc.extensions.postgres.PostgreSQLExceptionSorter \
    --connection-url=jdbc:postgresql://${DATASOURCE_CONNECTION_HOST}:${DATASOURCE_CONNECTION_PORT}/${DATASOURCE_CONNECTION_SCHEMA}

run-batch

EOF

function wait_for_server() {
  until `${WILDFLY_HOME}/bin/jboss-cli.sh -c "ls /deployment" &> /dev/null`; do
    sleep 1
  done
}

${WILDFLY_HOME}/bin/add-user.sh -g ${ADMIN_GROUP} -p ${ADMIN_PASSWORD} -u ${ADMIN_USERNAME}

${WILDFLY_HOME}/bin/standalone.sh -b ${BIND_IP} -bmanagement ${BIND_MANAGEMENT_IP} &

wait_for_server

${WILDFLY_HOME}/bin/jboss-cli.sh --connect -u=${ADMIN_USERNAME} -p=${ADMIN_PASSWORD} --file=/tmp/script.cli

#deploy ear
${WILDFLY_HOME}/bin/jboss-cli.sh --connect -u=${ADMIN_USERNAME} -p=${ADMIN_PASSWORD} --command="deploy --force ${PACKAGE_NAME}"

#test datasource
#${WILDFLY_HOME}/bin/jboss-cli.sh --connect -u=${ADMIN_USERNAME} -p=${ADMIN_PASSWORD} --command="/subsystem=datasources/data-source=PostgresqlDS:test-connection-in-pool"

${WILDFLY_HOME}/bin/jboss-cli.sh -u=${ADMIN_USERNAME} -p=${ADMIN_PASSWORD} --connect command=:shutdown
#/opt/jboss/wildfly/bin/standalone.sh -b ${BIND_IP} -bmanagement ${BIND_MANAGEMENT_IP} $@

exec "$@"
