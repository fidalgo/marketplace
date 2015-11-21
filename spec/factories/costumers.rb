FactoryGirl.define do
  factory :costumer do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'please123'
  end
end
