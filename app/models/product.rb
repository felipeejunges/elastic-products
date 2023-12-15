class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  serialize :sizes, Array
  serialize :colors, Array
  serialize :tags, Array

end

# == Schema Information
#
# Table name: products
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  description    :string
#  category       :string
#  brand          :string
#  sizes          :string
#  colors         :string
#  tags           :string
#  original_price :float
#  discount       :float
#  price          :float
#  available      :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
