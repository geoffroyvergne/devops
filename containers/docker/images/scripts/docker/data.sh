#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BACKUP_PATH=${3}
BACKUP_FILENAME=${4}
CONTAINER_NAME=${5}
WEB_PATH=${7:-"/mnt/www"}
DATA_IMAGE="gvergne/debian:latest"

case "$1" in
    mariadb)
        docker create -v /var/lib/mysql --name mariadb-data gvergne/debian:latest /bin/true
        exit 0
    ;;

    postgresql)
        docker create -v /var/lib/postgresql/9.4/main --name postgresql-data gvergne/debian:latest /bin/true
        exit 0
    ;;

    *)
        echo "Usage: data.sh {mariadb,postgresql}"
        exit 1
    ;;
esac
