class SelectBoxView extends Backbone.View
  multiple: false
  initialize: (options) ->
    _.bindAll this, "render", "select"
    @collection = options.collection
    @collection.bind "reset", @render
    @_optionViews = []
    
    # Render initial select box
    @el.append render.selectBox(
      label: options.label
      id: options.id
      className: options.className
    )
    @$select = @$("select")

  events:
    "change select": "select"

  render: ->
    i = 0
    @$select.prettybox("destroy").empty()
    @collection.each _((that, model) ->
      view = new BM.views.SelectBoxOptionView(model: model)
      el = view.render().el.appendTo(that.$select)
      el.attr "selected", true  if i is 0
      i++
    ).partial(this)
    unless @multiple
      @$select.attr "multiple", false
      @$select.prettybox()
    else
      @$select.attr "multiple", true
    @$select.trigger "change"
    this # for chaining

  select: (ev) ->
    value = @$select.val()
    @collection.each (model) ->
      name = model.get("name")
      if (_.isArray(value) and _.include(value, name)) or name is value
        model.set selected: true
      else
        model.set selected: false

    @trigger "select"
