m    = require 'mithril'
uuid = require 'uuid'

Todo = (data={}) ->
  data.id   ?= uuid.v4()
  data.done ?= false

  id:          m.prop data.id
  description: m.prop data.description
  done:        m.prop data.done

module.exports = Todo
