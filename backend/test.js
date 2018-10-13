const db = require('./lib/db.js')

return db.getHost('dev-venga-backend-accounts', '21a9ea8e-dfa2-4ccc-acc7-98666a52f4fd')
.then(items => {
  console.log(items)
})
