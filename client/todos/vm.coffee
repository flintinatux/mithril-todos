_     = require 'lodash'
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
      vm.list.unshift new Todo description: vm.description()
      vm.clear()

  vm.allDone = ->
    return false unless vm.list.length
    _.all vm.list, (todo) -> todo.done()

  vm.clear = ->
    vm.description ''
    document.getElementById('description').focus()

  vm.remove = (removed, e) ->
    e.stopPropagation()
    vm.list.splice vm.list.indexOf(removed), 1

  vm.reorder = (e) ->
    todo = vm.list.splice(e.oldIndex, 1)[0]
    vm.list.splice e.newIndex, 0, todo
    m.redraw.strategy 'all'
    m.redraw()

  vm.toggleAll = ->
    done = not vm.allDone()
    _.each vm.list, (todo) ->
      todo.done(done)
      true

  vm

window.vm = module.exports = vm
