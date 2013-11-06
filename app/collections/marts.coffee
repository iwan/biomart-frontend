class bmf.collections.Marts extends Backbone.Collection
  model: bmf.models.Mart
  url:   "/api/marts"
  # initialize: ->
  #   that = this
  #   
  #   # Hook into jquery
  #   # Use withCredentials to send the server cookies
  #   # The server must allow this through response headers
  #   $.ajaxPrefilter (options, originalOptions, jqXHR) ->
  #     options.crossDomain = crossDomain: true
  #     options.xhrFields = withCredentials: true
  #     
  #     # If we have a csrf token send it through with the next request
  #     #jqXHR.setRequestHeader "X-CSRF-Token", that.get("_csrf")  if typeof that.get("_csrf") isnt "undefined"
