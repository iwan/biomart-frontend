
#
#     * Paginator view provides page links for a Paginator object.
#     *
#     * Events triggers:
#     *     "page" - passes the page number (one-indexed) as the argument
#     
class PaginatorView extends Backbone.View
  tagName: "p"
  className: "model-paginator"
  _defaultPagesToDisplay: 10
  events:
    "click .ui-page": "page"

  initialize: ->
    _.bindAll this, "render"
    @model.bind "change", @render
    @$el = $(@el)

  render: (model) ->
    log "PaginatorView.render()"
    currPage = model.get("currPage")
    pages = model.get("pages")
    options = pages: []
    last = _.last(pages)
    start = undefined
    end = undefined
    
    # no pages to render
    return  unless pages.length
    
    # Put currPage in the middle of page links
    start = Math.max(1, currPage - Math.floor(@_defaultPagesToDisplay / 2) + 1)
    
    # If start + (# pages to display) puts us out of range
    start = Math.max(1, last - @_defaultPagesToDisplay + 1)  if start + @_defaultPagesToDisplay > last
    end = Math.min(_.last(pages), start + @_defaultPagesToDisplay)
    
    # Figure out prev and next pages if applicable
    options.prevPage = currPage - 1  if currPage > 1
    options.nextPage = currPage + 1  if currPage < last
    
    # Populate pages array
    i = start

    while i <= end
      options.pages.push
        num: i
        isActive: i is currPage

      
      # Only display a set number of pages for pagination
      break  if options.pages.length >= @_defaultPagesToDisplay
      i++
    
    # Attach rendered pages to view element
    @$el.html render.pages(options)
    this # for chaining

  page: (evt) ->
    clicked = $(evt.target)
    num = clicked.data("page")
    log "Page clicked", num
    @model.set currPage: num
    @trigger "page", num