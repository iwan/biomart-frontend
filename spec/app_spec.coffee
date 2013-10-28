describe "bmf.App", ->
  root = null
  app  = null

  beforeEach ->
    root = $("<div>")
    app = new bmf.App(root)

  it "should say hello to human gene", ->
    Backbone.history.navigate "gene_retrieval/human", trigger: true
    expect(root.text()).toMatch "retrieving human gene"

  it "should say hello to animal gene", ->
    Backbone.history.navigate "gene_retrieval/animal", trigger: true
    expect(root.text()).toMatch "retrieving animal gene"
