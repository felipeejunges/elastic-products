# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

2000.times do
  p = Product.new(name: Faker::Commerce.product_name, description: Faker::Lorem.paragraph, category: Faker::Commerce.department,
  brand: Faker::Company.name, sizes: [Faker::Lorem.word, Faker::Lorem.word, Faker::Lorem.word], available: true,
  colors: [Faker::Color.color_name, Faker::Color.color_name], tags: [Faker::Lorem.word, Faker::Lorem.word], 
  original_price: Faker::Commerce.price(range: 50..500.0), discout: Faker::Commerce.price(range: 15..90.0))
  p.price = original_price - (original_price * discount / 100)
end