$ ->
	$el = $("<div>")
	router = new bmf.Router routes: bmf.Routes, $el: $el
	Backbone.history.start pushState: true if !Backbone.History.started
	new bmf.views.Dashboard(el: $("#container"))

