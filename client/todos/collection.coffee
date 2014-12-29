Collection = require '../lib/collection'
Todo = require './model'

Todos = new Collection 'todos'

Todos.defaults [
    description: 'Go to the bank'
    description: 'Walk the dog after lunch'
    description: 'Ship all the things'
  ]

Todos.model Todo

module.exports = Todos
