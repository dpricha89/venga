'use strict'

// init dot env to inject the environment
// variable from the .env file
require('dotenv')
    .config()

// local libraries
const stripeCustomer = require('../../lib/stripeCustomer.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('stripe.customerSources')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)
  const body = JSON.parse(event.body)

  const stripeSource = body.source
  const stripeId = event.requestContext.authorizer.stripe_id

  return stripeCustomer.updateSources(stripeId, stripeSource)
        .then(customer => {
          log.info(`Successfully updated sources ${stripeId} for customer ${stripeSource}`)
          utls.successResponse(callback)
        })
        .catch(err => {
          log.error(err)
          callback(JSON.stringify(err))
        })
}
