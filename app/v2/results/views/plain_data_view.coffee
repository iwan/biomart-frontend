#
#     * PlainDataView renders a ResultData object in a <pre/> element in plaintext.
#     *
#     * Other data views extend this prototype.
#     
class PlainDataView extends Backbone.View
  tagName: "pre"
  className: "biomart-results-plaintext"
  _noDataClassName: "biomart-results-nodata"
  initialize: (options) ->
    _.bindAll this, "updateHeader", "displayRow", "done", "render", "clear"
    @$el = $(@el)
    @model.bind "change:header", @updateHeader
    @model.bind "add:row", @displayRow
    @model.bind "reset", @clear
    @model.bind "loaded", @done

  render: ->
    log "PlainDataView.render()"
    this

  updateHeader: (model) ->
    @$el.append model.headers.join("\t") + "\n"

  displayRow: (model, row, index) ->
    @$el.append row.join("\t") + "\n"

  done: (model) ->
    log "PlainDataView.done()"
    
    # If no data returned, show "No data" message
    @$el.html(_("no data").i18n(BM.i18n.CAPITALIZE)).addClass @_noDataClassName  if model.getTotal() is 0

  clear: ->
    log "PlainDataView.clear()"
    @$el.removeClass @_noDataClassName
    @$thead.empty()
    @$tbody.empty()