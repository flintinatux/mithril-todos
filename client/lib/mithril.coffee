m = require 'mithril'

origProp = m.prop

m.prop = (store) ->
  prop = origProp store

  prop.toggle = ->
    prop not prop()

  prop

module.exports = m
