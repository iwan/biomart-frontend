class FilterListView extends Backbone.View
  tagName: "ul"
  className: "collection-filter clearfix"
  initialize: (options) ->
    _.bindAll this, "render"
    @collection = options.collection
    @collection.bind "reset", @render

  render: ->
    @collection.each _((that, model) ->
      view = new BM.views.FilterView(model: model)
      $(view.render().el).appendTo that.el
      view.bind "all", (evtName, data) ->
        that.trigger evtName, data

    ).partial(this)
    this
