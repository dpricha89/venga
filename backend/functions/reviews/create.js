'use strict'

// init dot env
require('dotenv')
    .config()

// third party libraries
const uuidV4 = require('uuid/v4')

// local libraries
const db = require('../../lib/db.js')

const validation = require('../../lib/validation.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('reviews.create')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)

  // parse event body as json
  const body = JSON.parse(event.body)
  // attach UUID
  body.id = uuidV4()

  if (!validation.review(body)) {
    const err = 'Review object could not be validated'
    log.error(err)
    callback(JSON.stringify(err))
  }

  // Create a new trip
  return db.put(process.env.TRIPS_TABLE, body)
  .then(items => {
    utls.successResponse(callback, null)
  })
  .catch(err => {
    log.error(err)
    callback(JSON.stringify(err))
  })
}
