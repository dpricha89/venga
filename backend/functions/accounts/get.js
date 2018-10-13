'use strict'

// init dot env
require('dotenv')
    .config()

// local libraries
const db = require('../../lib/db.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('accounts.get')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)

  return db.get(process.env.ACCOUNTS_TABLE, event.requestContext.authorizer.email)
        .then(results => {
          utls.successResponse(callback, results)
        })
        .catch(err => {
          log.error(err)
          callback(JSON.stringify(err))
        })
}
