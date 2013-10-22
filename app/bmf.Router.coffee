bmf.navigate = (fragment, options) ->
  options = _.extend {trigger: true}, options
  Backbone.history.navigate(fragment, options)

class bmf.Router extends Backbone.Router
  initialize: ->
    for [action, route] in _(bmf.Routes).pairs().reverse()
      @route(route, action)
