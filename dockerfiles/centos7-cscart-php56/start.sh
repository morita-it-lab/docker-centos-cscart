#!/bin/bash

SETUP_CONF_FILE="/etc/httpd/conf.d/${SETUP_HTTPD_CONF_NAME}"
if [ ! -e $SETUP_CONF_FILE ]; then
	echo "ServerName ${SERVER_NAME}" > ${SETUP_CONF_FILE}
	if [ ${STDOUT_ERROR_LOG} = "TRUE" ]; then
		echo "ErrorLog /dev/stdout" >> ${SETUP_CONF_FILE}
	fi
	if [ ${STDOUT_CUSTOM_LOG} = "TRUE" ]; then
		echo "CustomLog /dev/stdout combined" >> ${SETUP_CONF_FILE}
	fi
fi

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/* /tmp/httpd*

exec /usr/sbin/apachectl -D FOREGROUND
