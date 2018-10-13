'use strict'

module.exports.run = (event, context, callback) => {
  // build the url
  let url = 'venga-stripe-redirect://oauth'
  for (var key in event.queryStringParameters) {
    url += (url.split('?')[1] ? '&' : '?') + `${key}=${event.queryStringParameters[key]}`
  }

  callback(null, {
    statusCode: 302,
    headers: {
      Location: url
    },
    body: JSON.stringify(event.queryStringParameters)
  })
}
