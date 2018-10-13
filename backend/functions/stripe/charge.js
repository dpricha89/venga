'use strict'

// Init dot env to inject the environment
// variable from the .env file
require('dotenv')
    .config()

// local libraries
const stripeCustomer = require('../../lib/stripeCustomer.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('stripe.charge')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)
  // parse the body
  const body = JSON.parse(event.body)

  const amount = body.amount
  const stripeSource = body.source
  const stripeId = event.requestContext.authorizer.stripe_id
  const user = event.requestContext.authorizer

  return stripeCustomer.charge(amount, stripeSource, user)
        .then(result => {
          log.info(`Successful charge for stripe id ${stripeId} | ${user.id} for source ${stripeSource}`)
          utls.successResponse(callback, result)
        })
        .catch(err => {
          log.error(err)
          callback(JSON.stringify(err))
        })
}
