#!/bin/bash

set -e
set -x

# constants
export REGION='us-west-2'
export CONFIG_FILE='.env'
export STAGE='dev'
export SERVICE='venga-backend'
export MEMORY=128
export TIMEOUT=30

# create .dotenv environment file
echo "ACCOUNTS_TABLE=${STAGE}-${SERVICE}-accounts" > $CONFIG_FILE
echo "HOSTS_TABLE=${STAGE}-${SERVICE}-hosts" >> $CONFIG_FILE
echo "DESTINATIONS_TABLE=${STAGE}-${SERVICE}-destinations" >> $CONFIG_FILE
echo "EXPERIENCES_TABLE=${STAGE}-${SERVICE}-experiences" >> $CONFIG_FILE
echo "TRIPS_TABLE=${STAGE}-${SERVICE}-trips" >> $CONFIG_FILE
echo "REVIEWS_TABLE=${STAGE}-${SERVICE}-reviews" >> $CONFIG_FILE
echo "STATIC_BUCKET=venga-static" >> $CONFIG_FILE
echo "REGION=${REGION}" >> $CONFIG_FILE
echo "STAGE=${STAGE}" >> $CONFIG_FILE
echo "MEMORY=${MEMORY}" >> $CONFIG_FILE
echo "TIMEOUT=${TIMEOUT}" >> $CONFIG_FILE
echo "JWT_SECRET=${JWT_SECRET}" >> $CONFIG_FILE
echo "SUMO_ENDPOINT=${SUMO_ENDPOINT}" >> $CONFIG_FILE
echo "DATA_DOG_KEY=${DATA_DOG_KEY}" >> $CONFIG_FILE
echo "DATA_DOG_SECRET=${DATA_DOG_SECRET}" >> $CONFIG_FILE
echo "TWILIO_SID=${TWILIO_SID}" >> $CONFIG_FILE
echo "TWILIO_TOKEN=${TWILIO_TOKEN}" >> $CONFIG_FILE

# lint the javascript files
# this ensures that we all write similar code
gulp standard

# npm install only required
npm install --production
# remove the unneeded libs
npm dedupe
