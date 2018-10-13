'use strict'

// init dot env
require('dotenv')
    .config()

const storage = require('../../lib/storage.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('images.urls')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)
  // parse event body as json
  const body = JSON.parse(event.body)
  const user = event.requestContext.authorizer

  // Get the s3 urls
  return storage.getPreSignedUrls(process.env.STATIC_BUCKET, user.id, body.titles)
  .then(result => {
    log.info(`Returned pre-signed image urls id: ${user.id}`)
    utls.successResponse(callback, result)
  })
  .catch(err => {
    log.error(err)
    callback(JSON.stringify(err))
  })
}
