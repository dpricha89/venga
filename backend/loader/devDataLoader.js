'use strict'

// 3rd party imports
const Promise = require('bluebird')
const fs = require('fs')
const path = require('path')

// local imports
const db = require('../lib/db.js');

// local dev data files
const base = path.resolve('.');

// get the json files
const dev_accounts = JSON.parse(fs.readFileSync('../resources/data/dev_accounts.json', 'utf8'))
const dev_destinations = JSON.parse(fs.readFileSync('../resources/data/dev_destinations.json', 'utf8'))
const dev_trips = JSON.parse(fs.readFileSync('../resources/data/dev_trips.json', 'utf8'))
const dev_reviews = JSON.parse(fs.readFileSync('../resources/data/dev_reviews.json', 'utf8'))

/*
This is run in the deployment script and loads the demo data into the dev database
*/
return Promise.map(dev_accounts, account => {
  return db.put('dev-venga-backend-accounts', account)
})
.then(() => {
  return Promise.map(dev_destinations, destination => {
    return db.put('dev-venga-backend-destinations', destination)
  })
})
.then(() => {
  const expDirectory = '../resources/data/experiences/'
  return fs.readdirSync(expDirectory).forEach(file => {
    console.log(`Trying to parse ${file}`)
    const experienceArray = JSON.parse(fs.readFileSync(expDirectory + file, 'utf8'))
    return Promise.map(experienceArray, experience => {
      return db.put('dev-venga-backend-experiences', experience)
    })
  })
})
.then(() => {
  return Promise.map(dev_trips, trip => {
    return db.put('dev-venga-backend-trips', trip)
  })
})
.then(() => {
  return Promise.map(dev_reviews, review => {
    return db.put('dev-venga-backend-reviews', review)
  })
})
