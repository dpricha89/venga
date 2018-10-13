'use strict'

// init dot env
require('dotenv')
    .config()

// local libraries
const db = require('../../lib/db.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('accounts.delete')

// constants
const PARAM_ERROR = 'ID was not found in request'

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)

  // get the email from params
  const id = event.pathParameters.id

  if (!id) {
    log.warn(PARAM_ERROR)
    callback(PARAM_ERROR)
  }

    // send delete signal to the db
  db.delete(process.env.ACCOUNTS_TABLE, id)
        .then(results => {
          log.info(`Successfully deleted user with id: ${id}`)
            // return 200
          utls.successResponse(callback)
        })
        .catch(err => {
          log.error(err)
          callback(JSON.stringify(err))
        })
}
