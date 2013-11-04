#
#     * Represents the entire query; Contains a list of QueryElements.
#     *
#     * Can compile to XML, Java, and SPARQL.
#     * TODO: Implement Java and SPARQL compilation
#     *
#     * Propagates events from QueryElementList:
#     *  - add : new QueryElement added
#     *  - remove : QueryElement removed
#     *  - attribute:add : new Attribute added
#     *  - attribute:remove : Attribute removed
#     *  - filter:add : new Filter added
#     *  - filter:remove : Filter removed
#     
class Query extends Backbone.Model
  defaults:
    processor: "TSV"
    limit: -1
    header: true
    client: "webbrowser"

  initialize: ->
    _.bindAll this, "_propagateEvent"
    @queryElements = new self.QueryElementList
    @queryElements.bind "all", @_propagateEvent

  _propagateEvent: (eventName) ->
    log "Query._propagateEvent", eventName
    @trigger.apply this, Array::slice.call(arguments_, 0)

  addElement: (queryElement) ->
    log "Query.addElement"
    @queryElements.add queryElement
    this

  removeElement: (queryElement) ->
    log "Query.removeElement"
    @queryElements.remove queryElement
    this

  getElement: (config) ->
    @queryElements.detect (element) ->
      element.get("config") is config


  
  #
  #         * Compiles the Query object into a string. Takes an optional **format**
  #         * argument -- default is XML.
  #         
  compile: (format) ->
    format = format or "xml"
    @_compileFunctions[format].call this

  
  #
  #         * Compile query for preview (i.e. with a limit)
  #         
  compileForPreview: (format) ->
    oldLimit = @get("limit")
    oldProcessor = @get("processor")
    @set
      limit: BM.PREVIEW_LIMIT
    ,
      silent: true

    
    # So we can see links
    if oldProcessor is "TSV"
      @set
        processor: "TSVX"
      ,
        silent: true

    compiled = @compile(format)
    @set
      limit: oldLimit
      processor: oldProcessor
    ,
      silent: true

    compiled

  _compileFunctions:
    xml: ->
      arr = []
      arr.push ["<Query processor=\"", @escape("processor"), "\" header=\"", @escape("header"), "\" limit=\"", @escape("limit"), "\"  client=\"", @escape("client"), "\">"].join("")
      @queryElements.each (queryElement) ->
        arr.push queryElement.compile("xml")

      arr.push "</Query>"
      arr.join ""

    java: ->
      arr = []
      arr.push "import org.biomart.api.factory.*;"
      arr.push "import org.biomart.api.Portal;"
      arr.push "import org.biomart.api.Query;\n"
      arr.push "/*"
      arr.push " * This is a runnable Java class that executes the query."
      arr.push " * Please adapt this code as needed, and DON'T forget to change the xmlPath."
      arr.push " */\n"
      arr.push "public class QueryTest {"
      arr.push "    public static void main(String[] args) throws Exception {"
      arr.push "        String xmlPath = \"/path/to/registry_xml\"; // Needs to be changed\n"
      arr.push "        MartRegistryFactory factory = new XmlMartRegistryFactory(xmlPath, null);"
      arr.push "        Portal portal = new Portal(factory, null);"
      arr.push "\n        Query query = new Query(portal);"
      arr.push ["        query.setProcessor(\"", @escape("processor"), "\");"].join("")
      arr.push ["        query.setClient(\"", @escape("client"), "\");"].join("")
      arr.push ["        query.setLimit(", @escape("limit"), ");"].join("")
      arr.push ["        query.setHeader(", @escape("header"), ");"].join("")
      @queryElements.each (queryElement) ->
        arr.push queryElement.compile("java")

      arr.push "\n        // Print to System.out, but you can pass in any java.io.OutputStream"
      arr.push "        query.getResults(System.out);"
      arr.push ["\n        System.exit(0);"].join("")
      arr.push "    }"
      arr.push "}"
      arr.join "\n"

    sparql: ->
      arr = []
      @queryElements.each (queryElement) ->
        arr.push queryElement.compile("sparql")

      arr.push "LIMIT " + @get("limit") + "\n"  if @get("limit") > 0
      arr.join ""