#!/bin/bash

set -e
set -x

# source base setup script
source base-setup.bash

echo "Loading data into the development tables..."
node ./loader/devDataLoader.js

echo "Starting serverless deployment"
serverless deploy --service $SERVICE --stage $STAGE --region $REGION --memory $MEMORY --timeout $TIMEOUT

#echo "Loading data into the development tables..."
#node ./loader/devDataLoader.js

exit 0
