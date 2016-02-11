#!/bin/bash

. $(dirname $0)/common_functions.sh

msg "Checking status of  webserver: $WEBSERVER_NAME"

service_status $WEBSERVER_NAME
if [ $? != 0 ]; then
    msg "Service $WEBSERVER_NAME is not running."
else
    msg "Service $WEBSERVER_NAME is running..."
fi
