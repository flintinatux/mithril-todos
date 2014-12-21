_    = require 'lodash'
path = require 'path'
watchify = require 'watchify'

paths =
  public: 'public'
  root:   path.resolve __dirname, '..'

module.exports =
  compressed: false
  mapped:     true
  paths:      paths
  revisioned: false

  browserify: _.extend {}, watchify.args,
    debug: true,
    extensions: ['.coffee']

  less:
    paths: [ "#{paths.root}/client/common" ]

  minify:
    keepSpecialComments: 0
