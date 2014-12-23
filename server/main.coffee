express = require 'express'
path    = require 'path'

app = express()

if app.get('env') is 'development'
  browserSync = require 'browser-sync'
  bs = browserSync files: 'public/**'
  app.use require('connect-browser-sync')(bs)

app.get '/', (req, res) ->
  res.sendFile 'index.html', root: 'public'

app.use express.static 'public'

app.listen 3030
