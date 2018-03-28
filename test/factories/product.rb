FactoryBot.define do

  factory :product do
     name FFaker::Product.product_name
     price { (rand() * rand(1..100)).round(2) }
   end
end
