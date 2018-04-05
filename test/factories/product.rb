FactoryBot.define do

  #first category is randomly selected
  factory :product do
     name FFaker::Product.product_name
     price { (rand() * rand(1..100)).round(2) }
     categories {|c| [c.association(:category)]}

     trait :multiple_categories do
       categories {|c| [c.association(:category), c.association(:category, :produce), c.association(:category, :bakery)]}
     end

   end
end
