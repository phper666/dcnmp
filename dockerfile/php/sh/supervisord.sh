#!/bin/bash

if [ "${SUPERVISORD_INSTALL}" == true ]; then
    echo
    echo "============ install supervisord service ==============="
    echo
    echo "---------- Install supervisor ----------"
    apk add --no-cache supervisor

    echo
    echo "============ mkdir supervisor ==============="
    echo
    mkdir /var/run/supervisord
    mkdir /var/log/supervisord

    echo
    echo "============ start supervisord service ==============="
    echo

    supervisord -c /etc/supervisord.conf
    supervisorctl reread
    supervisorctl update
    supervisorctl restart all
fi
