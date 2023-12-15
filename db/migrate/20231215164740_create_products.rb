class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :type
      t.string :brand
      t.string :sizes
      t.string :colors
      t.string :tags
      t.float :original_price
      t.float :discount
      t.float :price
      t.boolean :available

      t.timestamps
    end
  end
end
