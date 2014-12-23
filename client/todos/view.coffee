m  = require 'mithril'
vm = require './vm'

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
        m 'li.todo', { class: if todo.done() then 'complete' else '' }, [
          m 'label', [
            m 'input[type=checkbox]',
              onchange: m.withAttr 'checked', todo.done
              checked:  todo.done()
            m 'i.done'
            m 'span.description', todo.description()
          ]
        ]
    ]
  ]
