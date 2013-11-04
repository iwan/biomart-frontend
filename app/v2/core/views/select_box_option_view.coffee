class SelectBoxOptionView extends Backbone.View
  initialize: (options) ->
    _.bindAll this, "render"
    @model.bind "change", @render

  render: ->
    @el = $("<option>" + @model.get("name") + "</option>")
    this
