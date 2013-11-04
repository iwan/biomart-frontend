class AttributeListView extends Backbone.View
  tagName: "ul"
  className: "collection-attribute clearfix"
  initialize: (options) ->
    _.bindAll this, "render"
    @collection = options.collection
    @collection.bind "reset", @render

  render: ->
    @collection.each _((that, model) ->
      view = new BM.views.AttributeView(model: model)
      view.bind "all", (evtName, data) ->
        that.trigger evtName, data

      $(view.render().el).appendTo that.el
    ).partial(this)
    this
