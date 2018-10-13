'use strict'

//
// Used to update existing users (homeless people)
//

// init dot env to inject the environment
// variable from the .env file
require('dotenv')
    .config()

// local libraries
const db = require('../../lib/db.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('accounts.update')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)
  // parse event body as json
  var user = JSON.parse(event.body)

  // add updated date to user object
  user.updated = new Date()
        .getTime()

  // db method to update the user
  return db
        .update(process.env.ACCOUNTS_TABLE, event.pathParameters.id, user)
        .then(result => {
          log.info(`Successful update of account with id: ${event.pathParameters.id}`)
          // return status code 204 for update success
          utls.successResponse(callback, result)
        })
        .catch(err => {
          log.error(err)
          callback(JSON.stringify(err))
        })
}
