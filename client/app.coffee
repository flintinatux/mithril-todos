require './lib/core_ext'

window.m     = require 'mithril'
window.todos = require './todos'

m.module document.body, todos
