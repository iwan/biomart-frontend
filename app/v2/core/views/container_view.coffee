class ContainerView extends Backbone.View
  initialize: (options) ->
    _.bindAll this, "render"
    @model.bind "change", @render
    @_subContainerViews = []

  render: ->
    that = this
    filterList = @model.filterList
    attributeList = @model.attributeList
    containerList = @model.containerList
    @$rendered.remove()  if @$rendered
    
    # Render THIS container
    @$rendered = render.container(@model.toJSON()).appendTo(@el)
    
    # Render attributes
    if attributeList.length
      @_attributesView = new BM.views.AttributeListView(collection: attributeList)
      @_attributesView.bind "all", (evtName, data) ->
        that.trigger evtName, data

      @$rendered.append @_attributesView.render().el
    
    # Render filters
    if filterList.length
      @_filtersView = new BM.views.FilterListView(collection: filterList)
      @_filtersView.bind "all", (evtName, data) ->
        that.trigger evtName, data

      @$rendered.append @_filtersView.render().el
    
    # Render sub containers
    @model.containerList.each (container) ->
      newView = new BM.views.ContainerView(
        el: that.$rendered
        model: container
      ).render()
      newView.bind "all", (evtName, data) ->
        that.trigger evtName, data

      that._subContainerViews.push newView

    this
