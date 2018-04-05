FactoryBot.define do

  factory :order do
     status 0
     association :customer, :products, :placements
   end

end
