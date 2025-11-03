FactoryBot.define do
  factory :user do
    full_name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { "password123" }
    role { :admin }
    association :workspace
  end
end
