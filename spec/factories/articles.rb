FactoryBot.define do
  factory :article do
    task_title { "MyString" }
    task_description { "MyText" }
    status { 1 }
    priority { 1 }
    due_date { "2025-11-06 16:52:54" }
    title { "MyString" }
    slug { "MyString" }
    published_at { "2025-11-06 16:52:54" }
    workspace { nil }
    category { nil }
  end
end
