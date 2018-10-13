'use strict'

//
// Used to create new users on the platform
//

// init dot env to inject the environment
// variable from the .env file
require('dotenv')
    .config()

// local libraries
const account = require('../../lib/account.js')
const validation = require('../../lib/validation.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('accounts.signup')

// constants
const PARAM_ERROR = 'Validation of the body params has failed'

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)

    // parse event body as json
  var user = JSON.parse(event.body)

    // valid the body params
  if (!validation.user(user)) {
        // return error if the body cannot be validated
    log.warn(PARAM_ERROR)
    return callback(PARAM_ERROR)
  }

    // db method to create the new user
  return account.create(user)
        .then(result => {
          log.info(`Successful signup for user with id: ${result.id}`)
          // return status code 201 for created success
          utls.successResponse(callback, result)
        })
        .catch(err => {
          log.error(err)
          callback(JSON.stringify(err))
        })
}
