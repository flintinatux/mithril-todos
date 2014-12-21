_       = require 'lodash'
del     = require 'del'
gulp    = require 'gulp'
gulpif  = require 'gulp-if'
lazy    = require 'lazypipe'
merge   = require 'merge-stream'
minify  = require 'gulp-minify-css'
replace = require 'gulp-rev-replace'
rev     = require 'gulp-rev'
uglify  = require 'gulp-uglify'
util    = require 'gulp-util'

client  = require './tasks/client'
config  = require './tasks/config'
styles  = require './tasks/styles'

## pipes

compress = lazy()
  .pipe gulpif, '**/*.js',  uglify().on('error', util.log)
  .pipe gulpif, '**/*.css', minify(config.minify).on('error', util.log)

revision = lazy()
  .pipe rev
  .pipe replace
  .pipe gulp.dest, config.paths.public
  .pipe rev.manifest

## steps

build = ->
  merge [
    client.build()
    styles.build()
  ]
  .pipe gulpif config.compressed, compress()
  .pipe gulpif config.revisioned, revision()
  .pipe gulp.dest config.paths.public

## tasks

gulp.task 'build', ['clean'], build

gulp.task 'build:production', ['clean'], ->
  _.extend config,
    compressed: true
    mapped:     false
    revisioned: true
  _.extend config.browserify, debug: false
  build()

gulp.task 'clean', ['clean:client', 'clean:styles'], (done) ->
  del [ "#{config.paths.public}/rev-manifest.json" ], done

gulp.task 'default', ['watch']

gulp.task 'watch', ['watch:client', 'watch:styles']
