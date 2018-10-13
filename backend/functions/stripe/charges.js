'use strict'

// Init dot env to inject the environment
// variable from the .env file
require('dotenv')
    .config()

// local libraries
const stripeCustomer = require('../../lib/stripeCustomer.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('stripe.charges')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)

  // Get the stripe id from the authorizer
  const stripeId = event.requestContext.authorizer.stripe_id

  return stripeCustomer.getCharges(stripeId)
  .then(charges => {
    utls.successResponse(callback, charges)
  })
  .catch(err => {
    log.error(err)
    callback(JSON.stringify(err))
  })
}
