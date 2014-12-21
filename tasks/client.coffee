browserify = require 'browserify'
del        = require 'del'
gulp       = require 'gulp'
gulpif     = require 'gulp-if'
source     = require 'gulp-sourcemaps'
transform  = require 'vinyl-transform'
watchify   = require 'watchify'
util       = require 'util'

config = require './config'

## files

client = ['client/app.js']

## pipes

browserified = ->
  transform (filename) ->
    browserify config.browserify
      .add(filename)
      .bundle()

bundler = -> @bundle()

rebuild = (filename) ->
  gulp.src filename
    .pipe transform bundler.bind(@)
    .pipe gulp.dest config.paths.public

watchified = ->
  transform (filename) ->
    watcher = watchify browserify(config.browserify)
    watcher.on 'log', util.log
      .on 'update', rebuild.bind(watcher, filename)
      .add filename
      .bundle()

## streams

buildClient = ->
  gulp.src client
    .pipe browserified().on('error', util.log)

watchClient = ->
  gulp.src client
    .pipe watchified().on('error', util.log)
    .pipe gulp.dest config.paths.public

## tasks

gulp.task 'build:client', ['clean:client'], ->
  buildClient().pipe gulp.dest config.paths.public

gulp.task 'clean:client', (done) ->
  del [ "#{config.paths.public}/*.js" ], done

gulp.task 'watch:client', ['clean:client'], watchClient

## exports

exports.build = buildClient
