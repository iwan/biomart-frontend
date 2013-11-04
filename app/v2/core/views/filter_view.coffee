class FilterView extends Backbone.View
  tagName: "li"
  className: "model-filter clearfix"
  _activeClassName: "model-filter-active"
  events:
    "click .filter-remove": "removeFilter"
    "change .filter-field": "validateFilter"

  initialize: (options) ->
    _.bindAll this, "render", "updateFilter"
    @model.bind "change:selected", @updateFilter

  render: ->
    valueList = @model.get("values")
    filterList = @model.filterList.toJSON()
    
    # Helper variables for template 
    render.filter(_.extend(@model.toJSON(),
      filters: filterList
      isValid: @isValid()
      hasText: @hasTextField()
      isMultiple: @isMultiple()
      hasUpload: @hasUploadField()
    )).appendTo @el
    $(@el).addClass ["filter-", @model.get("type"), " model-filter-", @model.get("name")].join("")
    
    # Add an invalid "Choose" option to select boxes
    @$("select:not([multiple])").prepend(["<option value=\"\">-- ", _("select").i18n(BM.i18n.CAPITALIZE), " --</option>"].join("")).val("").prettybox()
    @$(".filter-item-name").append(":").bind "click.simplerfilter", ->
      
      # prevent checkbox from being checked/unchecked
      false

    @$(".filter-field-text").addClass("ui-state-default ui-corner-all").bind "focus.simplerfilter", ->
      $(this).select()

    @$(".filter-field-upload-file").uploadify()
    @$closeButton = $(["<span class=\"ui-icon ui-icon-circle-close filter-remove\" title=\"", _("remove").i18n(BM.i18n.CAPITALIZE), "\"></span>"].join("")).hide().appendTo(@el)
    this

  removeFilter: ->
    log "FilterView: Removing filter", @model.get("displayName")
    @model.set
      selected: false
      value: null

    @$(".filter-field").val ""
    @$(".ui-autocomplete-input").val ["-- ", _("select").i18n(BM.i18n.CAPITALIZE), " --"].join("")

  
  # TODO: Need some validation here
  validateFilter: ->
    value = @getValue()
    if value
      log "FilterView: Setting filter", @model.get("displayName"), value
      @model.set
        selected: true
        value: value

    else
      log "FilterView: Removing filter", @model.get("displayName")
      @model.set
        selected: false
        value: null


  updateFilter: ->
    log "FilterView: Updating filter view selection", @model.get("displayName")
    if @model.get("selected")
      $(@el).addClass @_activeClassName
      @$closeButton.show()
      @trigger "add",
        model: @model

    else
      $(@el).removeClass @_activeClassName
      @$closeButton.hide()
      @trigger "remove",
        model: @model


  _validationHandlers:
    text: ->
      true

    upload: ->
      true

    singleSelect: (model) ->
      !!model.get("values").length

    singleSelectBoolean: (model) ->
      !!model.filterList.length

    singleSelectUpload: (model) ->
      !!model.filterList.length

    multiSelect: (model) ->
      !!model.get("values").length

    multiSelectBoolean: (model) ->
      !!model.filterList.length

    multiSelectUpload: (model) ->
      !!model.filterList.length

  isValid: ->
    type = @model.get("type")
    handler = @_validationHandlers[type]
    return handler(@model)  if handler
    false

  hasUploadField: ->
    type = @model.get("type")
    /upload/i.test type

  hasTextField: ->
    type = @model.get("type")
    type is "text"

  isMultiple: ->
    type = @model.get("type")
    /multi/i.test type

  getValue: ->
    @$(".filter-value").val()
