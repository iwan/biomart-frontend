# 
#     * One-based index of pages
#     
class Paginator extends Backbone.Model
  defaults:
    pages: []
    currPage: 1

  reset: (options) ->
    silent = (if options then !!options.silent else false)
    @set
      pages: []
      currPage: 1
      silent: silent