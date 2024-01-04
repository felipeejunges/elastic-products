require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

sizes = ["XS", "S", "M", "L", "XL", "XLL"]
2000.times do |i|
  @brand = Faker::Company.name if @brand.nil? || i % 10 == 0 
  p = Product.new(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph, category: Faker::Commerce.department,
  brand: @brand, sizes: sizes.sample((1..6).to_a.sample), available: true,
  colors: [Faker::Color.color_name, Faker::Color.color_name], tags: [Faker::Lorem.word, Faker::Lorem.word], 
  original_price: Faker::Commerce.price(range: 50..500.0), discount: Faker::Commerce.price(range: 15..90.0))
  p.price = p.original_price - (p.original_price * p.discount / 100)
  p.save
end