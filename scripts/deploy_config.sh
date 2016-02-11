#!/bin/bash

. $(dirname $0)/common_functions.sh

# Deploy configuration files in customer repo under '/configuration/$DEPLOYMENT_GROUP_NAME/*'
msg "Deploying configuration for $DEPLOYMENT_GROUP_NAME"

# Get current time
msg "Started $(basename $0) at $(/bin/date "+%F %T")"
start_sec=$(/bin/date +%s.%N)

# Start the deployment
deploy_config
if [ $? != 0 ]; then
    error_exit "Unable to deploy application config to this instance; cannot continue."
fi

msg "Finished $(basename $0) at $(/bin/date "+%F %T")"

end_sec=$(/bin/date +%s.%N)
elapsed_seconds=$(echo "$end_sec - $start_sec" | /usr/bin/bc)

msg "Elapsed time: $elapsed_seconds"
