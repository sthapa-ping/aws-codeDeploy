#!/bin/bash

. $(dirname $0)/common_functions.sh

WEBSERVER_NAME='apache2'

msg "Stopping webserver: $WEBSERVER_NAME"

service_status $WEBSERVER_NAME
if [ $? != 0 ]; then
    msg "Service $WEBSERVER_NAME is not running; nothing to do."
else
  stop_service $WEBSERVER_NAME
  if [ $? != 0 ]; then
      error_exit "Unable to stop $WEBSERVER_NAME service; cannot continue."
  fi
fi
