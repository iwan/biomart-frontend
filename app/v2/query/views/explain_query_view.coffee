class ExplainQueryView extends Backbone.View
  tagName: "div"
  events:
    "click .close": "close"
    "click .escapeQuotes": "escapeQuotes"

  initialize: (options) ->
    @_target = options.target
    @_label = options.label

  source: (source) ->
    log "ExplainQueryView.source", source
    @_source = source
    this

  open: ->
    
    # Lazy creation of dialog when needed
    unless @$dialog
      @$dialog = render.queryDialog(title: @_label).appendTo(document.body).dialog(
        dialogClass: "biomart-query"
        autoOpen: false
        modal: true
        width: 700
        height: 450
        buttons:
          Close: ->
            $(this).dialog "close"
      )
    @$dialog.find("textarea").text(@_source).end().dialog "open"
    this

  close: ->
    @$dialog.dialog "close"
    this

  escapeQuotes: ->

  remove: ->
    @__super__ "remove"
    @$dialog.dialog("destroy").remove()  if @$dialog