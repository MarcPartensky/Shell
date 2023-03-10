const fs = require('fs');
const path = require('path');
const csv = require('fast-csv');

fs.createReadStream(path.resolve(__dirname, 'pass.csv'))
  .pipe(csv.parse({ headers: true }))
  .pipe(csv.format({ headers: true }))
// .on('data', row => console.log(row))
  .transform((row, next) => {
    let login = ''
    let url = ''

    if (row.comments && row.comments.match(/login: (.+)/)) {
      let match = row.comments.match(/login: (.+)/)
      login = match[1]
    }

    if (!login) {
      login = row.name
    }

    if (row.comments && row.comments.match(/url: (.+)/)) {
      let match = row.comments.match(/url: (.+)/)
      url = match[1]
    }

    return next(null, {
      folder: row.folder,
      favorite: '',
      type: 'login',
      name: row.name,
      notes: row.comments,
      fields: '',
      login_uri: url,
      login_username: login,
      login_password: row.password,
      login_totp: ''
    })
  })
 .pipe(process.stdout)
 .on('end', process.exit);


