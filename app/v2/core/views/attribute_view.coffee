class AttributeView extends Backbone.View
  tagName: "li"
  className: "model-attribute clearfix"
  _activeClassName: "model-attribute-active"
  events:
    "change input[type=checkbox]": "updateAttribute"

  initialize: (options) ->
    _.bindAll this, "updateCheckbox"
    @model.bind "change", @updateCheckbox

  render: ->
    render.attribute(@model.toJSON()).appendTo @el
    $(@el).addClass("model-attribute-" + @model.get("name")).data "view", this
    this

  updateAttribute: (evt) ->
    @model.set selected: evt.target.checked
    if @model.get("selected")
      $(@el).addClass @_activeClassName
      @trigger "add",
        model: @model

    else
      $(@el).removeClass @_activeClassName
      @trigger "remove",
        model: @model

    log "AttributeView: Updating attribute model", @model.get("displayName")

  updateCheckbox: ->
    input = @$("input[type=checkbox]")[0]
    input.checked = @model.get("selected")
    log "AttributeView: Updating attribute checkbox", @model.get("displayName")
