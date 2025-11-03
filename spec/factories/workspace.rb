FactoryBot.define do
  factory :workspace do
    name { Faker::Company.name }
    subdomain { Faker::Internet.unique.domain_word }
  end
end