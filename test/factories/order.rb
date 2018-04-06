FactoryBot.define do

  factory :order do
     status 0
     total 0
     association :customer, :products, :placements
   end

end
