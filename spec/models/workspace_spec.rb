require 'rails_helper'

RSpec.describe Workspace, type: :model do
  subject { build(:workspace) }

  it { should have_many(:users) }
  it { should have_many(:categories) }
  it { should have_many(:articles) }
  it { should have_many(:activity_logs) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:subdomain) }
  it { should validate_uniqueness_of(:subdomain) }
  it { should allow_value("workspace").for(:subdomain) }
  it { should_not allow_value("My workspace!").for(:subdomain) }
end
