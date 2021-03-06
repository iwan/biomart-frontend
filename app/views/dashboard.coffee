class bmf.views.Dashboard extends Backbone.View
  template: JST['templates/dashboard']

  initialize: ->
    _.bindAll this, "render"
    @marts = new bmf.collections.Marts
    @configuration = new bmf.models.Configuration
    # Fetch the collection and call render() method
    that = this
    @configuration.fetch success: ->
      that.render()

  render: ->
    # Fill the html with the template and the collection
    $(@el).html @template(configuration: @configuration.toJSON())
    # Nav links
    $(@el).find('ul li:first a').attr 'href', @geneRetrievalLink
    $(@el).find('ul li:nth-child(2) a').attr 'href', @variantRetrievalLink
    $(@el).find('ul li:nth-child(3) a').attr 'href', @sequenceRetrievalLink
    $(@el).find('ul li:last a').attr 'href', @idConverterLink
    this

  geneRetrievalLink: =>
    bmf.Paths.gene_retrieval()

  variantRetrievalLink: =>
    bmf.Paths.variant_retrieval()

  sequenceRetrievalLink: =>
    bmf.Paths.sequence_retrieval()

  idConverterLink: =>
    bmf.Paths.id_converter()
