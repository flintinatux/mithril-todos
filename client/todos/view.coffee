m  = require 'mithril'
vm = require './vm'

module.exports = ->
  m '.container', [
    m 'h1.title', 'Todos'
    m 'form', { onsubmit: vm.add }, [
      m "input.newTodo.form-control[type=text][placeholder='I need to...']",
        oninput: m.withAttr 'value', vm.description
        value:   vm.description()
    ]

    m 'ul.todos', [
      vm.list.map (todo) ->
        m 'li.todo', [
          m 'label', [
            m 'input.done[type=checkbox]',
              onchange: m.withAttr 'checked', todo.done
              checked:  todo.done()
            m 'span.description',
              style:
                textDecoration: if todo.done() then 'line-through' else 'none'
            , todo.description()
          ]
        ]
    ]
  ]
