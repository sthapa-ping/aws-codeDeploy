#!/bin/bash

. $(dirname $0)/common_functions.sh

# Check the node type; update record set in a hosted zone if its master node
if [[ $DEPLOYMENT_GROUP_NAME == *-master ]];
then
        update_record_set
else
        msg "No need to update record set on $DEPLOYMENT_GROUP_NAME node"
fi
