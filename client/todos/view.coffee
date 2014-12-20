m  = require 'mithril'
vm = require 'client/todos/vm.coffee'

module.exports = ->
  m 'html', [
    m 'body', [
      m 'h1.title', 'Todos'
      m 'form.newTodo', { onsubmit: vm.add }, [
        m 'input',
          oninput: m.withAttr 'value', vm.description
          value:   vm.description()
        m 'button[type=submit]', 'Add'
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
  ]
