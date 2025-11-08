require 'rails_helper'

RSpec.describe Article, type: :model do
  describe "Association" do
    it { should belong_to(:workspace) }
    it { should belong_to(:category).optional }
    it { should belong_to(:creator) }
    it { should belong_to(:writer).optional }
    it { should belong_to(:reviewer).optional }
    it { should have_many(:article_versions) }
    it { should have_many(:activity_logs) }
    # it { should have_rich_text(:content) }
  end

  describe "Validation" do
    it { should define_enum_for(:status).with_values(todo: 0, draft: 1, in_review: 2, published: 3, archived: 4) }
    it { should define_enum_for(:priority).with_values(low: 0, medium: 1, high: 2) }
  end
end
