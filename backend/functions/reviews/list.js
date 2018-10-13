'use strict'

// init dot env
require('dotenv')
    .config()

// third party libraries

// const _ = require('underscore')

// local libraries
const db = require('../../lib/db.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('reviews.list')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)

  // return all reviews for the experience
  return db.queryReviews(process.env.REVIEWS_TABLE, event.pathParameters.experience)
  .then(items => {
    utls.successResponse(callback, items)
  })
  .catch(err => {
    log.error(err)
    callback(JSON.stringify(err))
  })
}
