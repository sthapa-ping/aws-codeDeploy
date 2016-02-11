#!/bin/bash

. $(dirname $0)/common_functions.sh

msg "enable apache2 sites: $VHOST"

enable_sites
if [ $? != 0 ]; then
    warning "Unable to enable sites with vhost wildcard: $VHOST!"
fi
