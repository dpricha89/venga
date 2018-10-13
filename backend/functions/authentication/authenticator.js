'use strict'

// libraries
const authentication = require('../../lib/authentication.js')

// init dot env
require('dotenv')
    .config()

module.exports.run = (event, context, callback) => {
  // verify the token
  return authentication.verify(event, process.env.JWT_SECRET)
        .then(response => {
          callback(null, response)
        })
        .catch(err => {
          callback(err)
        })
}
