_    = require 'lodash'
m    = require 'mithril'
util = require '../common/util'

module.exports = (vm) ->
  m '#todos', [
    m 'header.header.container', [
      m 'h1.title', 'Todo List'

      m 'form.newTodo', { onsubmit: vm.add }, [
        m 'i.menu[title=Menu]'

        m "i.toggleAll[title='Toggle all']",
          class:   if vm.allDone() then 'allDone' else ''
          onclick: vm.toggleAll

        m "input#description[type=text][placeholder='I need to...']",
          oninput: m.withAttr 'value', vm.description
          value:   vm.description()

        m "i.clear[title=Clear]",
          class: if vm.description() then '' else 'hidden'
          onclick: vm.clear
      ]
    ]

    m 'section.content.container', [
      m 'ul.todos', [
        vm.sortedList().map (todo) ->
          m 'li.todo',
            class: if todo.done() then 'done' else ''
          , [
            m 'i.reorder[title=Reorder]'

            m 'i.status[title=Done]',
              onclick: util.toggle todo, 'done'

            m 'span.description', todo.description()

            m 'i.remove[title=Remove]',
              onclick: _.partial vm.remove, todo
          ]
      ]
    ]
  ]
