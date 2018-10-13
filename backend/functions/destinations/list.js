'use strict'

// init dot env
require('dotenv')
    .config()

// local libraries
const db = require('../../lib/db.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('destinations.list')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)
  // return all the experiences
  return db.scan(process.env.DESTINATIONS_TABLE)
  .then(items => {
    utls.successResponse(callback, items)
  })
  .catch(err => {
    log.error(err)
    callback(JSON.stringify(err))
  })
}
