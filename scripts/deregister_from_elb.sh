#!/bin/bash
#

. $(dirname $0)/common_functions.sh

msg "Running AWS CLI with region: $(get_instance_region)"

# get this instance's ID
INSTANCE_ID=$(get_instance_id)
if [ $? != 0 -o -z "$INSTANCE_ID" ]; then
    error_exit "Unable to get this instance's ID; cannot continue."
fi

# Get current time
msg "Started $(basename $0) at $(/bin/date "+%F %T")"
start_sec=$(/bin/date +%s.%N)

msg "Checking if instance $INSTANCE_ID is part of an AutoScaling group"
asg=$(autoscaling_group_name $INSTANCE_ID)
if [ $? == 0 -a -n "${asg}" ]; then
    msg "Found AutoScaling group for instance $INSTANCE_ID: ${asg}"
    
    msg "Checking that installed CLI version is at least at version required for AutoScaling Standby"
    check_cli_version
    if [ $? != 0 ]; then
        error_exit "CLI must be at least version to work with AutoScaling Standby"
    fi

    msg "Attempting to put instance into Standby"
    autoscaling_enter_standby $INSTANCE_ID "${asg}"
    if [ $? != 0 ]; then
        error_exit "Failed to move instance into standby"
    else
        msg "Instance is in standby"
        exit 0
    fi
fi

msg "Instance is not part of an ASG, continuing..."

msg "Checking if there is load balancer needed to deregister from"
if [ -z "$ELB_ID" -o "$ELB_ID" == "null" ]; then
    warning "[!!WARNING!!] Must have at least one load balancer to deregister from"
else
    msg "Checking validity of load balancer named '$ELB_ID'"
    validate_elb $INSTANCE_ID $ELB_ID
    if [ $? != 0 ]; then
        warning "Error validating $ELB_ID; cannot continue with this LB"
    fi

    msg "Deregistering $INSTANCE_ID from $ELB_ID"
    deregister_instance $INSTANCE_ID $ELB_ID

    if [ $? != 0 ]; then
        error_exit "Failed to deregister instance $INSTANCE_ID from ELB $ELB_ID"
    fi

# Wait for all Deregistrations to finish
  msg "Waiting for instance to de-register from its load balancers"
  wait_for_state "elb" $INSTANCE_ID "OutOfService" $ELB_ID
  if [ $? != 0 ]; then
      error_exit "Failed waiting for $INSTANCE_ID to leave $ELB_ID"
  fi

  msg "Finished $(basename $0) at $(/bin/date "+%F %T")"

  end_sec=$(/bin/date +%s.%N)
  elapsed_seconds=$(echo "$end_sec - $start_sec" | /usr/bin/bc)

  msg "Elapsed time: $elapsed_seconds"
fi
