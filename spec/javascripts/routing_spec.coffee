describe "Routes", ->
  describe "gene retrieval", ->
    it "should have an index route", ->
      expect(bmf.Routes.gene_retrieval).toEqual("gene_retrieval")

  describe "variant retrieval", ->
    it "should have an index route", ->
      expect(bmf.Routes.variant_retrieval).toEqual("variant_retrieval")

  describe "sequence retrieval", ->
    it "should have an index route", ->
      expect(bmf.Routes.sequence_retrieval).toEqual("sequence_retrieval")

  describe "id converter", ->
    it "should have an index route", ->
      expect(bmf.Routes.id_converter).toEqual("id_converter")

describe "Paths", ->
  describe "gene retrieval", ->
    it "should have an index path", ->
      expect(bmf.Paths.gene_retrieval()).toEqual("/gene_retrieval")

  describe "variant retrieval", ->
    it "should have an index path", ->
      expect(bmf.Paths.variant_retrieval()).toEqual("/variant_retrieval")

  describe "sequence retrieval", ->
    it "should have an index path", ->
      expect(bmf.Paths.sequence_retrieval()).toEqual("/sequence_retrieval")

  describe "id converter", ->
    it "should have an index path", ->
      expect(bmf.Paths.id_converter()).toEqual("/id_converter")
