module.exports =
  toggle: (model, prop) ->
    -> model[prop] not model[prop]()
