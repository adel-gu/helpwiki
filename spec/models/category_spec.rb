require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should belong_to(:workspace) }
  it { should belong_to(:creator) }
  it { should belong_to(:parent_category).optional }
  it { should have_many(:sub_categories) }
  it { should have_many(:articles) }
  it { should validate_presence_of(:name) }
end
