window.m = require('mithril')
window.todos = require('./modules/todos')

m.module(document, todos)
