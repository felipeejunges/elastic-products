FactoryBot.define do
    factory :product do
      name { Faker::Commerce.product_name }
      description { Faker::Lorem.paragraph }
      category { Faker::Commerce.department }
      brand { Faker::Company.name }
      sizes { [Faker::Lorem.word, Faker::Lorem.word] }
      colors { [Faker::Color.color_name, Faker::Color.color_name] }
      tags { [Faker::Lorem.word, Faker::Lorem.word] }
      original_price { Faker::Commerce.price(range: 50..500.0) }
      discount { Faker::Commerce.price(range: 15..90.0) }
      price { original_price - (original_price * discount / 100) }
      available { true }
  
      trait :unavailable do
        available { false }
      end
    end
  end