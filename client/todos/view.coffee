_    = require 'lodash'
m    = require 'mithril'
vm   = require './vm'
util = require '../common/util'

module.exports = ->
  m '.container', [
    m 'h1.title', 'Todo List'

    m 'form.newTodo', { onsubmit: vm.add }, [
      m "input#description[type=text][placeholder='I need to...']",
        oninput: m.withAttr 'value', vm.description
        value:   vm.description()

      m "button.action.toggleAll[type=button][title='Toggle all']",
        onclick: vm.toggleAll
      , [
        m 'i.fa', class: if vm.allDone() then 'allDone' else ''
      ]

      m "button.action.clear[type=button][title='Clear']",
        class: if vm.description() then '' else 'hidden'
        onclick: vm.clear
      , m.trust '&times;'
    ]

    m 'ul.todos', [
      vm.sortedList().map (todo) ->
        m 'li.todo',
          class: if todo.done() then 'done' else ''
          onclick: util.toggle todo, 'done'
        , [
          m 'i.status'
          m 'span.description', todo.description()
          m 'button.action.remove[title=Remove]',
            onclick: _.partial vm.remove, todo
          , m.trust '&times;'
        ]
    ]
  ]
