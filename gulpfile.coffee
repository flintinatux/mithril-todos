_      = require 'lodash'
del    = require 'del'
gulp   = require 'gulp'
gulpif = require 'gulp-if'
lazy   = require 'lazypipe'
merge  = require 'merge-stream'
minify = require 'gulp-minify-css'
replace = require 'gulp-rev-replace'
rev    = require 'gulp-rev'
uglify = require 'gulp-uglify'
util   = require 'gulp-util'

config = require './tasks/config'
styles = require './tasks/styles'

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
    styles.build()
  ]
  .pipe gulpif config.compress, compress()
  .pipe gulpif config.revision, revision()
  .pipe gulp.dest config.paths.public

## tasks

gulp.task 'build', ['clean'], build

gulp.task 'build:production', ['clean'], ->
  _.extend config,
    compressed: true
    mapped:     false
    revisioned: true
  build()

gulp.task 'clean', ['clean:styles'], (done) ->
  del [ "#{config.paths.public}/rev-manifest.json" ], done

gulp.task 'default', ['watch']

gulp.task 'watch', ['watch:styles']
