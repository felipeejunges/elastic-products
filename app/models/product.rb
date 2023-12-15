class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  serialize :sizes, Array
  serialize :colors, Array
  serialize :tags, Array
end
