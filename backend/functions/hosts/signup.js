'use strict'

//
// Used to create new hosts on the platform
//

// init dot env to inject the environment
// variable from the .env file
require('dotenv')
    .config()

// local libraries
const host = require('../../lib/host.js')
const validation = require('../../lib/validation.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('hosts.signup')

// constants
const PARAM_ERROR = 'Validation of the body params has failed'

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)

  // parse event body as json
  var hostObj = JSON.parse(event.body)

  // valid the body params
  if (!validation.host(hostObj)) {
    // return error if the body cannot be validated
    log.warn(PARAM_ERROR)
    return callback(PARAM_ERROR)
  }

  // get the user object from the authorizer
  const user = event.requestContext.authorizer

  // send the host to be created
  return host.signup(user, hostObj)
  .then(result => {
    log.info(`Successful created new host`)
    // return status code 204 for update success
    utls.successResponse(callback, result)
  })
  .catch(err => {
    log.error(err)
    callback(JSON.stringify(err))
  })
}
