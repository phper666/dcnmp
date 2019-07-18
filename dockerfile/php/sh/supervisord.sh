#!/bin/bash

echo
echo "============ install supervisord service ==============="
echo

if [ "${SUPERVIOSORD_INSTALL}" == true ]; then
    echo "---------- Install supervisor ----------"
    apk add --no-cache supervisor

    echo
    echo "============ mkdir supervisor ==============="
    echo
    mkdir /var/run/supervisor

    echo
    echo "============ start supervisord service ==============="
    echo

    supervisord -c /etc/supervisord.conf
    supervisorctl reread
    supervisorctl update
    supervisorctl restart all
fi
