del    = require 'del'
concat = require 'gulp-concat'
gulp   = require 'gulp'
gulpif = require 'gulp-if'
less   = require 'gulp-less'
source = require 'gulp-sourcemaps'

config = require './config'

## files

styles = [
  'bower_components/normalize.css/normalize.css'
  'client/**/!(includes).less'
]

## streams

buildStyles = ->
  gulp.src styles, base: '/'
    .pipe gulpif config.mapped, source.init()
    .pipe gulpif '**/*.less', less(config.less)
    .pipe concat 'app.css'
    .pipe gulpif config.mapped, source.write()

## tasks

gulp.task 'build:styles', ['clean:styles'], ->
  buildStyles().pipe gulp.dest config.paths.public

gulp.task 'clean:styles', (done) ->
  del [ "#{config.paths.public}/*.css" ], done

gulp.task 'watch:styles', ['build:styles'], ->
  gulp.watch styles, ['build:styles']

## exports

exports.build = buildStyles
