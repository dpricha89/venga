'use strict'

//
// Used to reset passwords for users on the platform
//

// init dot env to inject the environment
// variable from the .env file
require('dotenv')
    .config()

// local libraries
const authentication = require('../../lib/authentication.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('accounts.reset')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)

  // parse event body as json
  const body = JSON.parse(event.body)
  const email = event.requestContext.authorizer.email

  return authentication.resetPassword(email, body.current_password, body.new_password)
    .then(result => {
      log.info(`Successful reset for user ${email}`)
      // return
      utls.successResponse(callback)
    })
    .catch(err => {
      log.error(err)
      callback(JSON.stringify(err))
    })
}
