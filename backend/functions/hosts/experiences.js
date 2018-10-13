'use strict'

// init dot env
require('dotenv')
    .config()

// local libraries
const db = require('../../lib/db.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('hosts.experiences')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)

  // Get the account id from the authorizer, which is the host id we should
  // query for in the experiences
  const hostId = event.requestContext.authorizer.id

  // return all the experiences
  return db.queryHostExperiences(process.env.EXPERIENCES_TABLE, hostId)
  .then(items => {
    utls.successResponse(callback, items)
  })
  .catch(err => {
    log.error(err)
    callback(JSON.stringify(err))
  })
}
