describe "Router", ->
  root = "/"
  router = null
  spy    = null
  $el = null
  
  beforeEach ->
    router = new bmf.Router routes: bmf.Routes, $el: $el
    spy = jasmine.createSpy("RouteEvent")
    Backbone.history.start #root: bmf.root, pushState: true

  afterEach -> expect(spy).toHaveBeenCalled()

  it "should route to gene_retrieval index", ->
    router.on('route:gene_retrieval', spy())
    bmf.navigate(bmf.Paths.gene_retrieval())
    
  it "should route to variant_retrieval index", ->
    router.on('route:variant_retrieval', spy())
    bmf.navigate(bmf.Paths.variant_retrieval())

