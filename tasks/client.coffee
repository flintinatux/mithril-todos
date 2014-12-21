_          = require 'lodash'
browserify = require 'browserify'
del        = require 'del'
gulp       = require 'gulp'
gulpif     = require 'gulp-if'
lazy       = require 'lazypipe'
rename     = require 'gulp-rename'
source     = require 'gulp-sourcemaps'
transform  = require 'vinyl-transform'
watchify   = require 'watchify'
util       = require 'util'

config = require './config'

## files

client = './client/app.coffee'

## transpilers

bundler = browserify(config.browserify).add client
watcher = _.memoize ->
  watchify bundler
    .on 'log', util.log
    .on 'update', watchClient

## pipes

browserified = ->
  transform -> bundler.bundle()

dest = lazy().pipe gulp.dest, config.paths.public

renamer = lazy().pipe rename,
  dirname: 'assets'
  extname: '.js'

watchified = ->
  transform -> watcher().bundle()

## streams

buildClient = ->
  gulp.src client, base: '/'
    .pipe browserified()
    .pipe renamer()

watchClient = ->
  gulp.src client, base: '/'
    .pipe watchified()
    .pipe renamer()
    .pipe dest()

## tasks

gulp.task 'build:client', ['clean:client'], ->
  buildClient().pipe dest()

gulp.task 'clean:client', (done) ->
  del [ "#{config.paths.public}/assets/app*.js" ], done

gulp.task 'watch:client', ['clean:client'], watchClient

## exports

exports.build = buildClient
