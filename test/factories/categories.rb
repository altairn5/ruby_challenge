FactoryBot.define do

  factory :category do
     name [:produce, :meat, :bakery, :deli].sample #picks a random category

     trait :produce do
       name 'produce'
     end

     trait :meat do
       name 'meat'
     end

     trait :deli do
       name 'deli'
     end

     trait :bakery do
       name 'bakery'
     end

   end
end
