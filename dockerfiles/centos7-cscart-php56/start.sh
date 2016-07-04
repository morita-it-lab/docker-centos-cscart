#!/bin/bash

SETUP_CONF_FILE="/etc/httpd/conf.d/${SETUP_HTTPD_CONF_NAME}"
if [ ! -e $SETUP_CONF_FILE ]; then
	echo "ServerName ${SERVER_NAME}" > $SETUP_CONF_FILE
fi

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/* /tmp/httpd*

exec /usr/sbin/apachectl -D FOREGROUND
