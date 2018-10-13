'use strict'

// init dot env
require('dotenv')
    .config()

// local libraries
const experience = require('../../lib/experience.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('experiences.create')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)

  // parse event body as json
  var body = JSON.parse(event.body)

  // Add the host id to the experience_id
  body.host_id = event.requestContext.authorizer.id
  // Add status of pending to the experience, so we can manually approve.
  body.status = 'Pending'

  // return all the experiences
  return experience.create(process.env.EXPERIENCES_TABLE, body)
  .then(items => {
    utls.successResponse(callback, items)
  })
  .catch(err => {
    log.error(err)
    callback(JSON.stringify(err))
  })
}
