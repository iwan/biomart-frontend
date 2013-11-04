class Container extends Backbone.Model
    url: ->
      params =
        datasets: @get("datasets")
        withattributes: @get("withattributes")
        withfilters: @get("withfilters")

      config = undefined
      params.config = config  if config = @get("mart").get("config")
      BM.conf.service.url + "containers?" + $.param(params)

    initialize: ->
      _.bindAll this, "parse"
      @containerList = new BM.models.ContainerList
      @attributeList = new BM.models.AttributeList
      @filterList = new BM.models.FilterList

    parse: (resp) ->
      that = this
      @set
        id: that.cid
        name: resp.name
        displayName: resp.displayName
        independent: resp.independent
        description: resp.description
        maxContainers: resp.maxContainers
        maxAttributes: resp.maxAttributes
        silent: true

      @containerList.reset _.map(resp.containers, (container) ->
        new BM.models.Container().parse container
      )
      
      @attributeList.reset _.map(resp.attributes, (attribute) ->
        new BM.models.Attribute().parse attribute
      )
      
      @filterList.reset _.map(resp.filters, (filter) ->
        new BM.models.Filter().parse filter
      )
      this