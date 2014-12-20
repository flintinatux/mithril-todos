path = require 'path'

paths =
  public: 'public'
  root:   path.resolve __dirname, '..'

module.exports =
  compressed: false
  mapped:     true
  paths:      paths
  revisioned: false

  less:
    paths: [ "#{paths.root}/client/common" ]

  minify:
    keepSpecialComments: 0
