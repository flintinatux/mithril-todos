_ = require 'lodash'
m = require 'mithril'
Sortable = require 'sortablejs'

module.exports = (vm) ->
  m '#todos', [
    m 'header.header.container', [
      m 'h1.title', 'Todo List'

      m 'form.newTodo', { onsubmit: vm.add }, [
        m 'i.toggleMenu[title=Menu]',
          onclick: vm.menuShown.toggle

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

      m 'nav.menu',
        class: if vm.menuShown() then 'shown' else ''
      , [
        m 'span.clearCompleted',
          onclick: vm.clearCompleted
        , 'Clear completed'

        m 'span.clearAll',
          onclick: vm.clearAll
        , 'Clear all'
      ]
    ]

    m 'section.content.container', [
      if not vm.list().length
        m 'p.none', 'No todos found. Please add one above!'
      else
        m 'ul.todos',
          config: (el, isInit, context) ->
            return if isInit
            sortable = new Sortable el,
              animation: 150
              handle: '.reorder'
              onEnd: vm.reorder
            context.onunload = -> sortable.destroy()
        , vm.list().map (todo) ->
            m 'li.todo',
              id: "todo-#{todo.id()}"
              class: if todo.done() then 'done' else ''
            , [
              m 'i.reorder[title=Reorder]'

              m 'i.status[title=Done]',
                onclick: todo.done.toggle

              m 'span.description', todo.description()

              m 'i.remove[title=Remove]',
                onclick: _.partial vm.remove, todo
            ]
    ]
  ]
