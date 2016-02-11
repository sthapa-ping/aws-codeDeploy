#!/bin/bash

. $(dirname $0)/common_functions.sh

# Check the node type; deploy application code only to master & slave nodes
if [[ $DEPLOYMENT_GROUP_NAME == *-calc ]];
then
  msg "No need to deploy application code on Calculation server"
else
  msg "Deploying application code to /var/www/"

  # Get current time
  msg "Started $(basename $0) at $(/bin/date "+%F %T")"
  start_sec=$(/bin/date +%s.%N)

  # Start the deployment
  deploy_app
  if [ $? != 0 ]; then
      error_exit "Unable to deploy application code to this instance; cannot continue."
  fi

  # Clean up configuration files
  clean_up "$APPLICATION__PATH/configuration/"

  msg "Finished $(basename $0) at $(/bin/date "+%F %T")"

  end_sec=$(/bin/date +%s.%N)
  elapsed_seconds=$(echo "$end_sec - $start_sec" | /usr/bin/bc)

  msg "Elapsed time: $elapsed_seconds"
fi
