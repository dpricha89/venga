'use strict'

// init dot env
require('dotenv')
    .config()

// local libraries
const host = require('../../lib/host.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('hosts.get')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)

  // Get the host id from the url params
  const hostId = event.pathParameters.host_id

  // return the host
  return host.get(hostId)
  .then(response => {
    utls.successResponse(callback, response)
  })
  .catch(err => {
    log.error(err)
    callback(JSON.stringify(err))
  })
}
