localforage = require 'localforage'
m = require 'mithril'

localforage.setDriver [localforage.WEBSQL, localforage.LOCALSTORAGE]

Collection = (name) ->
  c = m.prop []

  c.clear = ->
    c []
    c

  c.defaults = m.prop []

  c.load = ->
    localforage.getItem(name).then (vals) ->
      return console.log err if err?
      vals ?= c.defaults()
      c vals.map c.model()
      m.redraw()
    c

  c.model = m.prop (data={}) ->
    model = {}
    for own key, val of data
      model[key] = m.prop val
    model

  c.remove = (model) ->
    c().splice c().indexOf(model), 1
    c

  c.save = ->
    localforage.setItem(name, c()).catch (err) ->
      console.log err

  ['push', 'unshift'].forEach (method) ->
    c[method] = (data) ->
      c()[method] new c.model() data
      c

  c

module.exports = Collection
