class Product < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  searchkick word_start: [:name, :brand], suggest: [:name]

  serialize :sizes, Array
  serialize :colors, Array
  serialize :tags, Array
  
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, analyzer: 'english'
      indexes :description, analyzer: 'english'
      indexes :category, analyzer: 'english'
      indexes :brand, analyzer: 'english'
      indexes :sizes, type: 'keyword'
      indexes :colors, type: 'keyword'
      indexes :tags, type: 'keyword'
      indexes :original_price, type: 'float'
      indexes :discount, type: 'float'
      indexes :price, type: 'float'
    end
  end

  def search_data
    {
      name: name,
      description: description,
      category: category,
      brand: brand,
      sizes: sizes,
      colors: colors,
      tags: tags,
      original_price: original_price,
      discount: discount,
      price: price
    }
  end



  def as_json(options = {})
    super(
      only: [:id, :name, :description, :type, :brand, :sizes, :colors, :tags, :original_price, :discount, :price],
      methods: [:formatted_price]
    )
  end

  def formatted_price
    sprintf('$%.2f', price)
  end

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
