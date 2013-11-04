class Attribute extends Backbone.Model
    defaults:
      selected: false

    initialize: ->
      @attributeList = new BM.models.AttributeList

    parse: (resp) ->
      @set
        id: @cid
        name: resp.name
        displayName: resp.displayName
        description: resp.description
        isHidden: resp.isHidden
        value: resp.value
        linkURL: resp.linkURL
        silent: true

      this