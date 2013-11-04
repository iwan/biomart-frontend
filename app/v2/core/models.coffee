#
# * This modules containers the core BioMart models and collections
# 
_("BM.models").namespace (self) ->
  
  #
  #     * Models
  #     
  self.operations =
    MULTI_SELECT: "MULTISELECT"
    SINGLE_SELECT: "SINGLESELECT"

  self.GuiContainer = Backbone.Model.extend(
    url: ->
      BM.conf.service.url + ((if @name then "gui?name=" + @name else "portal"))

    initialize: (options) ->
      options.name and (@name = options.name)
      @marts = new BM.models.MartList

