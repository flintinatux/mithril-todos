express = require 'express'
path    = require 'path'

app = express()

app.get '/', (req, res) ->
  res.sendFile 'index.html', root: 'public'

app.use express.static 'public'

app.listen 3030
