class Filter extends Backbone.Model
    initialize: ->
      @set
        selected: false
        value: null
        silent: true

      @filterList = new BM.models.FilterList

    parse: (resp) ->
      that = this
      @set
        id: that.cid
        name: resp.name
        displayName: resp.displayName
        description: resp.description
        type: resp.type
        isHidden: resp.isHidden
        values: resp.values
        silent: true

      _.each resp.filters, (filter) ->
        newFilter = new BM.models.Filter
        newFilter.parse filter
        that.filterList.add newFilter

      this