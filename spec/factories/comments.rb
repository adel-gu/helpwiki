FactoryBot.define do
  factory :comment do
    content { "MyText" }
    article { nil }
    user { nil }
    comment_type { 1 }
  end
end
