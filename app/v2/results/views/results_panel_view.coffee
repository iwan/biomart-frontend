class ResultsPanelView extends Backbone.View
  _hiddenClassName: "hidden"
  events:
    "click .biomart-results-show": "showResults"
    "click .biomart-results-hide": "hideResults"

  _isOnHeaders: false
  initialize: (options) ->
    _.bindAll this, "callback", "done"
    @_iframeId = _.uniqueId("BioMart")
    
    # If data view is not specified, use plaintext
    @_dataViewClass = options.dataViewClass or self.PlainDataView
    @_dataViewOptions = options.dataViewOptions or {} # set options if exist
    @_dataModel = new BM.results.models.ResultData() # instantiate data model
    @_dataView = new @_dataViewClass(_.extend( # instantiate data view
      model: @_dataModel
    , @_dataViewOptions))
    @$content = $(@el).find(".biomart-results-content").addClass(@_hiddenClassName)
    @$loading = $("<span class=\"loading\"/>").hide().appendTo(@el)
    
    # iframe for streaming results from server
    @$iframe = $("<iframe class=\"streaming\" name=\"" + @_iframeId + "\"/>").appendTo(@$content)
    @$submitButton = @$(".biomart-results-show")
    @$backButton = @$(".biomart-results-hide")
    
    # form for submitting query
    @$form = $("<form class=\"streaming\" method=\"POST\" target=\"" + @_iframeId + "\" " + "action=\"" + BM.conf.service.url + "results\">" + "<input type=\"hidden\" name=\"query\"/>" + "<input type=\"hidden\" name=\"iframe\" value=\"true\"/>" + "<input type=\"hidden\" name=\"scope\" value=\"" + "BM_callbacks." + @_iframeId + "\"/>" + "<input type=\"hidden\" name=\"uuid\" value=\"" + @_iframeId + "\"/>" + "</form>").appendTo(@$content)
    window.BM_callbacks[@_iframeId] =
      write: @callback
      done: @done

  callback: (uuid, row) ->
    
    # Check that the row is not empty
    if row
      row = row.split("\t")
      if @_isOnHeaders
        @_dataModel.set header: row
        @_isOnHeaders = false
      else
        @_dataModel.addRow row

  done: (uuid) ->
    @_dataModel.done()
    @$loading.hide()

  showResults: ->
    @trigger "show"
    
    # Whether we need to handle headers first
    @_isOnHeaders = true  if @model.get("header")
    @$content.append(@_dataView.render().el).removeClass @_hiddenClassName
    @$form.find("input[name=query]").val(@model.compileForPreview()).end().submit()
    
    # Switch user controls
    @$submitButton.hide()
    @$backButton.show()
    @$loading.show()
    this

  hideResults: ->
    @trigger "hide"
    @$content.addClass @_hiddenClassName
    
    # Reset controls
    @$submitButton.show()
    @$backButton.hide()
    
    # Clear out results
    @_dataModel.reset()
    this