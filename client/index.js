window.m = require('mithril');
window.todos = require('client/todos/module.coffee');

m.module(document, todos);
