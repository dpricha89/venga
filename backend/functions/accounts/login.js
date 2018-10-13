'use strict'

// Init dot env variables
require('dotenv')
    .config()

// Local libraries
const authentication = require('../../lib/authentication.js')
const facebook = require('../../lib/facebook.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('accounts.login')

// constants
const PARAM_ERROR = 'Missing required parameters in body'

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)
  // parse event body as json
  const body = JSON.parse(event.body)

    // if facebook login then take different route
  if (body.facebookToken) {
    log.info('Trying to login with Facebook token')
    return facebook
            .createUser(body.facebookToken)
            .then(user => {
              log.info(`Successful facebook login with ${user.id}`)
              utls.successResponse(callback, user)
            })
            .catch(err => {
              log.error(JSON.stringify(err))
              callback(JSON.stringify(err))
            })
  }

    // ensure the correct parameters are available
  if (!body.email || !body.password) {
    log.warn(PARAM_ERROR)
    callback(PARAM_ERROR)
  }

    // normal login flow
  return authentication
        .check(body.email.toLowerCase(), body.password)
        .then(user => {
          log.info(`Successful user login with token ${user.id}`)
          utls.successResponse(callback, user)
        })
        .catch(err => {
          log.error(err)
          callback(JSON.stringify(err))
        })
}
