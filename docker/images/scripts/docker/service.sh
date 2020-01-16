#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
SCRIPT_DIR_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DOCKER_STATUS_COMMAND="docker ps -as"
DOCKER_STOP_COMMAND="docker stop"
DOCKER_REMOVE_COMMAND="docker rm -f"

case "$1" in
    start)
        echo "$1 $2"

        case "$2" in

            mariadb)
                ${SCRIPT_DIR_PATH}"/mariadb.sh"

                exit 0
            ;;

            postgresql)
                ${SCRIPT_DIR_PATH}"/postgresql.sh"

                exit 0
            ;;

            php-fpm)
                ${SCRIPT_DIR_PATH}"/php-fpm.sh"

                exit 0
            ;;

            jetty)
                ${SCRIPT_DIR_PATH}"/jetty.sh"

                exit 0
            ;;

            wildfly)
                ${SCRIPT_DIR_PATH}"/wildfly.sh"

                exit 0
            ;;

            nginx-static)
                ${SCRIPT_DIR_PATH}"/nginx-static.sh"

                exit 0
            ;;

            nginx-php)
                ${SCRIPT_DIR_PATH}"/nginx-php.sh"

                exit 0
            ;;

            haproxy-web)
                ${SCRIPT_DIR_PATH}"/haproxy-web.sh"

                exit 0
            ;;

            web-app)
                ${SCRIPT_PATH} start mariadb
                ${SCRIPT_PATH} start php-fpm
                ${SCRIPT_PATH} start jetty
                ${SCRIPT_PATH} start nginx-static
                ${SCRIPT_PATH} start nginx-php
                ${SCRIPT_PATH} start haproxy-web

                exit 0
            ;;

            jee-app)
                ${SCRIPT_PATH} start postgresql
                ${SCRIPT_PATH} start wildfly

                exit 0
            ;;

            jee-app-init)
                ${SCRIPT_DIR_PATH}/postgresql.sh "true"
                ${SCRIPT_PATH} start wildfly

                exit 0
            ;;

            *)
                echo "Services start : mariadb|postgresql|php-fpm|jetty|wildfly|nginx-status|nginx-php|haproxy-web|web-app|jee-app|jee-app-init"
                exit 1
            ;;
         esac
    exit 0
    ;;

    stop)
        echo "$1 $2"

        case "$2" in
            mariadb)
                ${DOCKER_STOP_COMMAND} mariadb-container
                exit 0
            ;;

            postgresql)
                ${DOCKER_STOP_COMMAND} postgresql-container
                exit 0
            ;;

            php-fpm)
                ${DOCKER_STOP_COMMAND} php-fpm-container
                exit 0
            ;;

            jetty)
                ${DOCKER_STOP_COMMAND} jetty-container
                exit 0
            ;;

            wildfly)
                ${DOCKER_STOP_COMMAND} wildfly-container
                exit 0
            ;;

            nginx-static)
                ${DOCKER_STOP_COMMAND} nginx-static-container
                exit 0
            ;;

            nginx-php)
                ${DOCKER_STOP_COMMAND} nginx-php-container
                exit 0
            ;;

            haproxy-web)
                ${DOCKER_STOP_COMMAND} haproxy-web-container
                exit 0
            ;;

            web-app)
                ${SCRIPT_PATH} stop mariadb
                ${SCRIPT_PATH} stop php-fpm
                ${SCRIPT_PATH} stop jetty
                ${SCRIPT_PATH} stop nginx
                ${SCRIPT_PATH} stop nginx-php
                ${SCRIPT_PATH} stop haproxy-web

                exit 0
            ;;

            jee-app)
                ${SCRIPT_PATH} stop postgresql
                ${SCRIPT_PATH} stop wildfly

                exit 0
            ;;

            *)
                echo "Services stop : mariadb|postgresql|php-fpm|jetty|wildfly|nginx-static|nginx-php|haproxy-web|web-app|jee-app"
                exit 1
            ;;
         esac
    exit 0
    ;;

    remove)
        echo "$1 $2"

        case "$2" in
            mariadb)
                ${DOCKER_REMOVE_COMMAND} mariadb-container
                exit 0
            ;;

            postgresql)
                ${DOCKER_REMOVE_COMMAND} postgresql-container
                exit 0
            ;;

            php-fpm)
                ${DOCKER_REMOVE_COMMAND} php-fpm-container
                exit 0
            ;;

            jetty)
                ${DOCKER_REMOVE_COMMAND} jetty-container
                exit 0
            ;;

            wildfly)
                ${DOCKER_REMOVE_COMMAND} wildfly-container
                exit 0
            ;;

            nginx-static)
                ${DOCKER_REMOVE_COMMAND} nginx-static-container
                exit 0
            ;;

            nginx-php)
                ${DOCKER_REMOVE_COMMAND} nginx-php-container
                exit 0
            ;;

            haproxy-web)
                ${DOCKER_REMOVE_COMMAND} haproxy-web-container
                exit 0
            ;;

            web-app)
                ${SCRIPT_PATH} remove mariadb
                ${SCRIPT_PATH} remove php-fpm
                ${SCRIPT_PATH} remove jetty
                ${SCRIPT_PATH} remove nginx
                ${SCRIPT_PATH} remove nginx-php
                ${SCRIPT_PATH} remove haproxy-web

                exit 0
            ;;

            jee-app)
                ${SCRIPT_PATH} remove postgresql
                ${SCRIPT_PATH} remove wildfly

                exit 0
            ;;

            *)
                echo "Services stop : mariadb|php-fpm|jetty|nginx-static|nginx-php|haproxy-web|web-app"
                exit 1
            ;;
         esac
    exit 0
    ;;

    status)
        echo "$1 $2"

        case "$2" in
            mariadb)
                ${DOCKER_STATUS_COMMAND} | grep mariadb-container
                exit 0
            ;;

            php-fpm)
                ${DOCKER_STATUS_COMMAND} | grep php-fpm-container
                exit 0
            ;;

            jetty)
                ${DOCKER_STATUS_COMMAND} | grep jetty-container
                exit 0
            ;;

            nginx-static)
                ${DOCKER_STATUS_COMMAND} | grep nginx-static-container
                exit 0
            ;;

            nginx-php)
                ${DOCKER_STATUS_COMMAND} | grep nginx-php-container
                exit 0
            ;;

            haproxy-web)
                ${DOCKER_STATUS_COMMAND} | grep haproxy-web-container
                exit 0
            ;;

            all)
                ${DOCKER_STATUS_COMMAND}
                exit 0
            ;;

            *)
                echo "Services status : mariadb|php-fpm|jetty|nginx|nginx-php|haproxy-web|all"
                exit 1
            ;;
        esac
    exit 0
    ;;

    list)
        echo "List services \n"

        echo "Up"
        docker ps
        echo ""

        echo "Data"
        docker ps -a | grep data
        echo ""

        echo "exited"
        docker ps -f status=exited
        echo ""

        exit 0
    ;;

    *)
        echo "Usage: service.sh {start|stop|remove|status|list} <service-name>"
        exit 1
    ;;
esac
