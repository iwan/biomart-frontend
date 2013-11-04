#     * A QueryElement contains a list of datasets + config, a list of attributes, 
#     * and a list of filters. Equal to the <Dataset/> element in query XML.
#     *
#     * Can compile down to XML, Java, and SPARQL queries.
#     *
#     * TODO: Implement Java and SPARQL compilation
#     
class QueryElement extends Backbone.Model
  sync: (method, model, success, error) ->

  
  # no service for this right now
  # TODO: move this to localStorage?
  url: "/queryelement" # This is meaningless right now due to lack of sync()
  initialize: (options) ->
    log "QueryElement: initialize", options.config
    _.bindAll this, "_propagateAttributeEvent", "_propagateFilterEvent"
    @set id: options.config
    @datasetList = new BM.models.DatasetList(@get("datasets"))
    @filterList = new BM.models.FilterList
    @attributeList = new BM.models.AttributeList

    @filterList.bind "all", @_propagateFilterEvent
    @attributeList.bind "all", @_propagateAttributeEvent

  _propagateAttributeEvent: (eventName, model) ->
    @trigger "attribute:" + eventName, model

  _propagateFilterEvent: (eventName, model) ->
    @trigger "filter:" + eventName, model

  compile: (format) ->
    fn = @_compileFunctions[format]
    if fn
      fn.apply this
    else
      throw "Could not find compile function for format: " + format

  
  #
  #         * Compiles the query into formats matched by key
  #         
  _compileFunctions:
    xml: ->
      arr = []
      datasets = @datasetList.toString()
      arr.push ["<Dataset name=\"", datasets, "\"", " config=\"" + @escape("config") + "\"", ">"].join("")
      @filterList.each (filter) ->
        arr.push ["<Filter name=\"", filter.escape("name"), "\"", " value=\"", filter.escape("value"), "\"/>"].join("")

      @attributeList.each (attribute) ->
        arr.push ["<Attribute name=\"", attribute.escape("name"), "\"/>"].join("")

      arr.push "</Dataset>"
      arr.join ""

    java: ->
      arr = []
      datasets = @datasetList.toString()
      arr.push ["\n        Query.Dataset ds = query.addDataset(\"", datasets, "\", ", (if @escape("config") then ("\"" + @escape("config") + "\"") else "null"), ");"].join("")
      @filterList.each (filter) ->
        arr.push ["        ds.addFilter(\"", filter.escape("name"), "\", \"", filter.escape("value"), "\");"].join("")

      @attributeList.each (attribute) ->
        arr.push ["        ds.addAttribute(\"", attribute.escape("name"), "\");"].join("")

      arr.join "\n"

    sparql: ->
      
      #
      #                 * Helper functions for SPARQL
      #                 
      site2reference = (siteURL) ->
        refURL = siteURL.replace(/^https:/, "biomart:")
        refURL = refURL.replace(/^http:/, "biomart:")
        refURL
      identifier2SPARQL = (id) ->
        
        # This regexp has to be identical to the regexp in ObjectController.createDefaultRDF
        id = "_" + id  unless id.match(/^[a-zA-Z_].*/)
        id
      arr = []
      config = @escape("config")
      datasets = @datasetList.toString()
      arr.push "PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>\n"
      arr.push "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>\n"
      arr.push "PREFIX owl: <http://www.w3.org/2002/07/owl#>\n"
      arr.push "\n"
      arr.push "PREFIX accesspoint: <" + BIOMART_CONFIG.siteURL + "martsemantics/" + config + "/ontology#>\n"
      arr.push "PREFIX class: <" + site2reference(BIOMART_CONFIG.siteURL) + "martsemantics/" + config + "/ontology/class#>\n"
      arr.push "PREFIX dataset: <" + site2reference(BIOMART_CONFIG.siteURL) + "martsemantics/" + config + "/ontology/dataset#>\n"
      arr.push "PREFIX attribute: <" + site2reference(BIOMART_CONFIG.siteURL) + "martsemantics/" + config + "/ontology/attribute#>\n\n"
      arr.push "SELECT "
      @attributeList.each (attribute) ->
        name = identifier2SPARQL(attribute.escape("name"))
        arr.push "?" + name + " "

      arr.push "\n"
      @datasetList.each (dataset) ->
        arr.push "FROM dataset:" + dataset.escape("name") + "\n"

      arr.push "WHERE {\n"
      @filterList.each (filter) ->
        name = identifier2SPARQL(filter.escape("name"))
        arr.push "  ?x attribute:" + name + " \"" + filter.escape("value") + "\" .\n"

      i = 0
      that = this
      @attributeList.each (attribute) ->
        name = identifier2SPARQL(attribute.escape("name"))
        arr.push "  ?x attribute:" + name + " ?" + name
        if ++i < that.attributeList.length
          arr.push " .\n"
        else
          arr.push "\n"

      arr.push "}\n"
      return arr.join("")

