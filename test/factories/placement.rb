FactoryBot.define do

  factory :placement do
     quantity 1
     #fix below
     trait :quantities do
       quantity rand(2..20)
     end
   end

end
