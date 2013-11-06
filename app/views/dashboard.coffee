class bmf.views.Dashboard extends Backbone.View
  template: JST['templates/dashboard']
  className: 'container'

  initialize: ->
    _.bindAll this, "render"
    @marts = new bmf.collections.Marts
    # console.log @marts.fetch()
    # console.log $(@el)

    # Fetch the collection and call render() method
    that = this
    @marts.fetch success: ->
      that.render()

    # $(@el).html @template(marts: @marts.toJSON())
    # $('container').append $(@el)
    # @

  render: ->
    # Fill the html with the template and the collection
    $(@el).html @template(marts: @marts.toJSON())
    this

  geneRetrievalLink: =>
    bmf.Paths.gene_retrieval()

  variantRetrievalLink: =>
    bmf.Paths.variant_retrieval()

  sequenceRetrievalLink: =>
    bmf.Paths.sequence_retrieval()

  idConverterLink: =>
    bmf.Paths.id_converter()
