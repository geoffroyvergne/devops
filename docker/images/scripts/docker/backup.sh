#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BACKUP_PATH=${3}

case "$1" in
    backup)
        echo "$1 $2"

        case "$2" in
            mariadb)
                docker rm -f ${CONTAINER_NAME}

                docker run --rm --volumes-from mariadb-data \
                -v ${BACKUP_PATH}:/backup \
                gvergne/debian:latest \
                sh -c "cd /var/lib && tar cvf /backup/mariadb.tar mysql"

                ${SCRIPT_PATH} start mariadb

                exit 0
            ;;

            postgresql)
                #docker rm -f ${CONTAINER_NAME}

                docker run --rm --volumes-from postgresql-data \
                -v ${BACKUP_PATH}:/backup \
                gvergne/debian:latest \
                sh -c "cd /var/lib && tar cvf /backup/postgresql.tar postgresql"

                #${SCRIPT_PATH} start postgresql

                exit 0
            ;;

            *)
                echo "data backup : {mariadb,postgresql}"
                exit 1
            ;;
        esac
    exit 0
    ;;

    restore)
        echo "$1 $2"

        case "$2" in

            mariadb)
                docker rm -f ${CONTAINER_NAME}

                docker run --rm --volumes-from ${CONTAINER_NAME} \
                -v ${BACKUP_PATH}:/backup \
                ${DATA_IMAGE} \
                sh -c "rm -Rf /var/lib/mysql/*"

                docker run --rm --volumes-from ${CONTAINER_NAME} \
                -v ${BACKUP_PATH}:/backup \
                ${DATA_IMAGE} \
                sh -c "cd /var/lib/mysql && tar xvf /backup/${BACKUP_FILENAME} --strip 1"

                ${SCRIPT_PATH} start mariadb

                exit 0
            ;;

            postgresql)
                docker rm -f ${CONTAINER_NAME}

                docker run --rm --volumes-from ${CONTAINER_NAME} \
                -v ${BACKUP_PATH}:/backup \
                ${DATA_IMAGE} \
                sh -c "rm -Rf /var/lib/postgresql/*"

                docker run --rm --volumes-from ${CONTAINER_NAME} \
                -v ${BACKUP_PATH}:/backup \
                ${DATA_IMAGE} \
                sh -c "cd /var/lib/postgresql && tar xvf /backup/${BACKUP_FILENAME} --strip 1"

                ${SCRIPT_PATH} start mariadb

                exit 0
            ;;

            *)
                echo "data restore : {mariadb,postgresql}"
                exit 1
            ;;
        esac
    exit 0
    ;;

    *)
        echo "Usage: backup.sh {backup|restore} {mariadb,postgresql} <BACKUP_PATH>"
        exit 1
    ;;
esac
