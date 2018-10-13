'use strict'

// init dot env
require('dotenv')
    .config()

// local libraries
const db = require('../../lib/db.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('trips.create')
const trips = require('../../lib/trips.js')
const twilio = require('../../lib/twilio.js')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)

  // parse event body as json
  const body = JSON.parse(event.body)
  // attach account_id from the token
  body.account_id = event.requestContext.authorizer.id

  // Create a new trip
  return db.put(process.env.TRIPS_TABLE, trips.validate(body))
  .then(items => {
    twilio.sendText()
    utls.successResponse(callback, null)
  })
  .catch(err => {
    log.error(err)
    callback(JSON.stringify(err))
  })
}
