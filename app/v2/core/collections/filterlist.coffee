class FilterList extends Backbone.Collection
  model: BM.models.Filter
  url: BM.conf.service.url + "filters"
