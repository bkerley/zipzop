# http://emberjs.com/guides/models/defining-a-store/

Zipzop.Store = DS.Store.extend
  revision: 11
  adapter: DS.RESTAdapter.create()

