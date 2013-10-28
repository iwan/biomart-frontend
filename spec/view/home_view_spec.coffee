describe 'Home Page View', ->
  model = null
  view  = null

  beforeEach ->
    model = new Backbone.Model { id: 1 }
    view =  new bmf.HomeView model: model
    view.render()

  it "has a link to Gene Retrieval", ->
    link = view.$el.find('ul li:first a').attr 'href'
    expect(link).toEqual bmf.Paths.gene_retrieval()

  it "has a link to Variant Retrieval", ->
    link = view.$el.find('ul li:nth-child(2) a').attr 'href'
    expect(link).toEqual bmf.Paths.variant_retrieval()

  it "has a link to Sequence Retrieval", ->
    link = view.$el.find('ul li:nth-child(3) a').attr 'href'
    expect(link).toEqual bmf.Paths.sequence_retrieval()

  it "has a link to ID Converter", ->
    link = view.$el.find('ul li:last a').attr 'href'
    expect(link).toEqual bmf.Paths.id_converter()
