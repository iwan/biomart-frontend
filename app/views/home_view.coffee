class bmf.HomeView extends Backbone.View

  template: Mustache.compile """
    <ul>
      <li><a href="{{ geneRetrievalLink }}">Gene Retrieval</a></li>
      <li><a href="{{ variantRetrievalLink }}">Variant Retrieval</a></li>
      <li><a href="{{ sequenceRetrievalLink }}">Sequence Retrieval</a></li>
      <li><a href="{{ idConverterLink }}">ID Converter</a></li>
    </ul>
  """

  render: ->
    @$el.html(@template(this))
    this

  geneRetrievalLink: =>
    bmf.Paths.gene_retrieval()

  variantRetrievalLink: =>
    bmf.Paths.variant_retrieval()

  sequenceRetrievalLink: =>
    bmf.Paths.sequence_retrieval()

  idConverterLink: =>
    bmf.Paths.id_converter()
