#!/bin/bash

PHP_ETC_DIR="/etc/php5/fpm/pool.d/www.conf"
PHP_INI_ETC_DIR="/etc/php5/fpm/php.ini"

CHANGE_CONFIG=${PHP_CHANGE_CONFIG:-"true"}

if [ -e /tmp/www.conf ]; then
    WWW_CONF=$(cat /tmp/www.conf)
    echo "${WWW_CONF}" > ${PHP_ETC_DIR}
fi

if [ -e /tmp/php.ini ]; then
    PHP_INI_CONF=$(cat /tmp/php.ini)
    echo "${PHP_INI_CONF}" > ${PHP_INI_ETC_DIR}
fi

if [ "$CHANGE_CONFIG" == "true" ];
then
    if [ -n "$PHP_BIND_HOST" ]
    then
    echo "PHP_BIND_HOST : "$PHP_BIND_HOST
    sed -i -e "s/listen = \/var\/run\/php5-fpm.sock/listen = $PHP_BIND_HOST/" ${PHP_ETC_DIR}
    fi

    if [ "$PHP_ENABLE_STATUS" == "true" ]
    then
    echo "PHP_ENABLE_STATUS : "$PHP_ENABLE_STATUS
    sed 's/;pm.status_path = \/status/pm.status_path = \/status/' -i ${PHP_ETC_DIR}
    sed 's/;ping.path = \/ping/ping.path = \/ping/' -i ${PHP_ETC_DIR}
    sed 's/;ping.response = pong/ping.response = pong/' -i ${PHP_ETC_DIR}
    fi

    if [ "$PHP_ENV" == "dev" ]
    then
    echo "PHP_ENV : "$PHP_ENV
    #Development Value: E_ALL
    #Production Value: E_ALL & ~E_DEPRECATED & ~E_STRICT
    #error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT
    #error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT
    sed 's/error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT/error_reporting = E_ALL/' -i ${PHP_INI_ETC_DIR}

    #display_errors = Off
    sed 's/display_errors = Off/display_errors = On/' -i ${PHP_INI_ETC_DIR}

    #expose_php = Off
    sed 's/expose_php = Off/expose_php = On/' -i ${PHP_INI_ETC_DIR}

    #display_errors = Off
    sed 's/expose_php = Off/expose_php = On/' -i ${PHP_INI_ETC_DIR}

    #display_startup_errors = Off
    sed 's/display_startup_errors = Off/display_startup_errors = On/' -i ${PHP_INI_ETC_DIR}

    #track_errors = Off
    sed 's/track_errors = Off/track_errors = On/' -i ${PHP_INI_ETC_DIR}

    #html_errors = Off
    sed 's/html_errors = Off/html_errors = On/' -i ${PHP_INI_ETC_DIR}
    fi

    if [ "$PHP_ENABLE_ASP_TAGS" == "true" ]
    then
    #asp_tags = Off
    sed 's/asp_tags = Off/asp_tags = On/' -i ${PHP_INI_ETC_DIR}
    fi

    if [ "$PHP_ENABLE_OPEN_TAGS" == "true" ]
    then
    #short_open_tag = Off
    sed 's/short_open_tag = Off/short_open_tag = On/' -i ${PHP_INI_ETC_DIR}
    fi
fi

exec "$@"