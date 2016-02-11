#!/bin/bash

. $(dirname $0)/common_functions.sh

WEBSERVER_NAME='apache2'

msg "Starting webserver: $WEBSERVER_NAME"

service_status $WEBSERVER_NAME
if [ $? != 0 ]; then
  start_service $WEBSERVER_NAME
  if [ $? != 0 ]; then
      error_exit "Unable to start $WEBSERVER_NAME service; cannot continue."
  fi
else
  msg "Service $WEBSERVER_NAME is not running; nothing to do."
fi


