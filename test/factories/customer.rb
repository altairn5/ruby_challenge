
FactoryBot.define do

  factory :customer do
     first_name { FFaker::Name.first_name }
     last_name  { FFaker::Name.last_name }
     email { FFaker::Internet.email }
     phone_number { FFaker::PhoneNumber.short_phone_number }
     password "1234555"
   end
end
