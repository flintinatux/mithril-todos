m = require 'mithril'

Todo = (data) ->
  @description = m.prop data.description
  @done        = m.prop false
  return

module.exports = Todo
