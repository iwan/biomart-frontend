class MartList extends Backbone.Collection
  model: BM.models.Mart
  url: BM.conf.service.url + "marts"
  selected: ->
    @detect (mart) ->
      mart.get "selected"