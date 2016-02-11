#!/bin/bash

. $(dirname $0)/common_functions.sh

# Disable vhost config, if the vhost config does not exists matching the wildcard then it wil returns 
# error.
msg "disable apache2 sites: $VHOST"

disable_sites
if [ $? != 0 ]; then
    warning "Ignore the error if vhost doesn't exists already"
fi
