m     = require 'mithril'
Todo  = require './model'
Todos = require './collection'

vm = {}

vm.init = ->
  vm.list = new Todos(
    new Todo description: 'Go to the bank'
    new Todo description: 'Walk the dog after lunch'
    new Todo description: 'Ship all the things'
  )

  vm.description = m.prop ''

  vm.add = (e) ->
    e.preventDefault()
    if vm.description()
      vm.list.push new Todo description: vm.description()
      vm.description ''

  vm

window.vm = module.exports = vm
