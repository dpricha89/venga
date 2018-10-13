'use strict'

// init dot env
require('dotenv')
    .config()

// local libraries
const db = require('../../lib/db.js')
const utls = require('../../lib/utls.js')
const log = utls.logs('trips.list')

module.exports.run = (event, context, callback) => {
  log.logGatewayEvent(event)

  // attach account_id from the token
  const accountId = event.requestContext.authorizer.id

  // return all the trips that match
  return db.queryTrips(process.env.TRIPS_TABLE, accountId)
  .then(trips => {
    // returned trips and get the experience data
    // get the experience from the database
    return db.getExperience(process.env.EXPERIENCES_TABLE, trips)
    .then(result => {
      log.info(result)
      // merge the two objects together (experiences + trip)
      return trips.map(trip => {
        const experience = result.find(experience => {
          return trip.experience_id === experience.id
        })
        trip.experience = experience
        return trip
      })
    })
  })
  .then(experiences => {
    // return the booked trips
    utls.successResponse(callback, experiences)
  })
  .catch(err => {
    log.error(err)
    callback(JSON.stringify(err))
  })
}
