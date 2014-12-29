_     = require 'lodash'
m     = require 'mithril'
Todos = require './collection'

done = (todo) -> todo.done()

vm = {}

vm.init = ->
  vm.description = m.prop ''
  vm.list        = Todos.load()
  vm.menuShown   = m.prop false

  vm.add = (e) ->
    e.preventDefault()
    if vm.description()
      vm.list.add(description: vm.description()).save()
      vm.clear()

  vm.allDone = ->
    return false unless vm.list().length
    _.all vm.list(), done

  vm.clear = ->
    vm.description ''
    document.getElementById('description').focus()

  vm.clearAll = ->
    vm.list.clear().save()

  vm.clearCompleted = ->
    vm.list _.reject(vm.list(), done)
    vm.list.save()

  vm.remove = (model) ->
    vm.list.remove(model).save()

  vm.reorder = (e) ->
    todo = vm.list().splice(e.oldIndex, 1)[0]
    vm.list().splice e.newIndex, 0, todo
    vm.list.save()
    m.redraw.strategy 'all'
    m.redraw()

  vm.toggleAll = ->
    allDone = not vm.allDone()
    _.each vm.list(), (todo) ->
      todo.done(allDone)
      true
    vm.list.save()

  vm

window.vm = module.exports = vm
