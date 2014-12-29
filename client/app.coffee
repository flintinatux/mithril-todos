require './lib/core_ext'

window.localforage = require 'localforage'
window.m     = require 'mithril'
window.todos = require './todos'

m.module document.body, todos
