FactoryBot.define do
  factory :article do
    association :workspace
    creator { :user }
  end
end
