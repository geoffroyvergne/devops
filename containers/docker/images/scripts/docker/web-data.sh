#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

#docker create -v /mnt/www:/var/www/html --name web-data gvergne/debian-server:latest /bin/true

docker create -v ${WEB_PATH}:/var/www/html --name ${CONTAINER_NAME} ${DATA_IMAGE} /bin/true