'use strict'

// Init dot env to inject the environment
// variable from the .env file
require('dotenv')
    .config()

// Local libraries
const stripeCustomer = require('../../lib/stripeCustomer.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('stripe.customer')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)

  const stripeId = event.requestContext.authorizer.stripe_id
  log.info(stripeId)
  return stripeCustomer.getCustomer(stripeId)
        .then(customer => {
          utls.successResponse(callback, customer)
        })
        .catch(err => {
          log.error(err)
          callback(JSON.stringify(err))
        })
}
