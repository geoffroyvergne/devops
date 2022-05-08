#!/bin/bash

ADMIN_USERNAME=${WILDFLY_ADMIN_USERNAME:-"admin"}
ADMIN_GROUP=${WILDFLY_ADMIN_GROUP:-"admin"}
ADMIN_PASSWORD=${WILDFLY_ADMIN_PASSWORD:-"admin"}

/opt/jboss/wildfly/bin/add-user.sh -g ${ADMIN_GROUP} -p ${ADMIN_PASSWORD} -u ${ADMIN_USERNAME}

exec "$@"