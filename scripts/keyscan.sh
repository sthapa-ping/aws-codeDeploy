#!/bin/bash

. $(dirname $0)/common_functions.sh

msg "Creating cron job to execute ssh-keygen"

ssh_keygen_cron
if [ $? != 0 ]; then
    warning "Unable to create cron job; cannot continue."
fi
