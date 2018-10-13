#!/bin/bash

set -x
set -e

# source base setup script
source base-setup.bash

echo "Starting to run service offline"
serverless offline start --service $SERVICE --stage $STAGE --region $REGION --memory $MEMORY --timeout $TIMEOUT
