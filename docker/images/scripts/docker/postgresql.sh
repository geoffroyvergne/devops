#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

INIT_DB=${1:-"false"}

if [ "$(docker ps -a | grep postgresql-data)" ];
then
    echo "postgresql-data exists"
else
    echo "postgresql-data doesnt exists"
    ${SCRIPT_DIR_PATH}/data.sh postgresql
fi

if [ "$(docker ps -a | grep postgresql-container)" ];
then
    echo "postgresql container already exists"
else
    echo "create postgresql container"

    docker run -d \
    --name postgresql-container \
    -p 5432:5432 \
    -e POSTGRES_INIT_DB=${INIT_DB} \
    -e POSTGRES_ADDUSER="wildfly" \
    -e POSTGRES_ADDPASSWORD="wildfly" \
    --volumes-from postgresql-data \
    postgresql -p 5432
fi

docker ps | grep mariadb-container