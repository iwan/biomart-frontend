$ ->
	$el = $("<div>")
	router = new bmf.Router routes: bmf.Routes, $el: $el
	Backbone.history.start pushState: true if !Backbone.History.started
	#Backbone.history.navigate "", trigger: true
	new bmf.views.Dashboard(el: $("#container"))

  #constructor: (@$el) ->
    #router = new GeneRetrievalRouter $el: @$el
    #Backbone.history.start pushState: true if !Backbone.History.started

#class GeneRetrievalRouter extends Backbone.Router
  #initialize: (options) ->
    #@$el = options.$el

  #routes:
    #"gene_retrieval/:name": "gene_retrieval"

  #gene_retrieval: (name) -> @$el.text "retrieving #{name} gene"

