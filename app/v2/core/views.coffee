_("BM.views").namespace (self) ->
  self.GuiContainerView = Backbone.View.extend(
    initialize: (options) ->
      _.bindAll this, "render", "update"
      @model.bind "change", @update
      @model.bind "change", @render
      @model.view = this

    update: ->
      @model.marts.reset @model.get("marts")

    render: ->
      @$(".guiContainerName").text @model.get("displayName")
      this
  )







