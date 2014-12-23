m  = require 'mithril'
vm = require './vm'

toggle = (model, prop) ->
  -> model[prop] not model[prop]()

module.exports = ->
  m '.container', [
    m 'h1.title', 'Todo List'
    m 'form', { onsubmit: vm.add }, [
      m "input.newTodo[type=text][placeholder='I need to...']",
        oninput: m.withAttr 'value', vm.description
        value:   vm.description()
    ]

    m 'ul.todos', [
      vm.list.map (todo) ->
        m 'li.todo',
          class: if todo.done() then 'done' else ''
          onclick: toggle todo, 'done'
        , [
          m 'i.status'
          m 'span.description', todo.description()
        ]
    ]
  ]
