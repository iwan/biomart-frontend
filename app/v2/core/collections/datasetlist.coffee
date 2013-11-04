class DatasetList extends Backbone.Collection
  model: BM.models.Dataset
  url: BM.conf.service.url + "datasets"
  
  initialize: (options) ->
    @mart = options.mart  if options and options.mart

  selected: ->
    @models.filter (ds) ->
      !!ds.get("selected")


  hasSelected: ->
    @models.some (ds) ->
      !!ds.get("selected")


  toString: ->
    arr = []
    @models.forEach (ds) ->
      arr.push ds.escape("name")  if ds.get("selected")

    arr.join ","
