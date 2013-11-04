class AttributeList extends Backbone.Collection
  model: BM.models.Attribute
  url: BM.conf.service.url + "attributes"