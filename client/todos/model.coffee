m    = require 'mithril'
uuid = require 'uuid'

Todo = (data) ->
  @id          = m.prop uuid.v4()
  @description = m.prop data.description
  @done        = m.prop false
  return

module.exports = Todo
