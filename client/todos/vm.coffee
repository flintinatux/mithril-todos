m     = require 'mithril'
Todo  = require 'client/todos/model.coffee'
Todos = require 'client/todos/collection.coffee'

vm = {}

vm.init = ->
  vm.list = new Todos()
  vm.description = m.prop ''

  vm.add = (e) ->
    e.preventDefault()
    if vm.description()
      vm.list.push new Todo description: vm.description()
      vm.description ''

  vm

window.vm = module.exports = vm
