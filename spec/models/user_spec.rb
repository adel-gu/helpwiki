require 'rails_helper'

RSpec.describe User, type: :model do

  it { should belong_to(:workspace).optional }
  it { should validate_presence_of(:full_name) }
  it { should define_enum_for(:role).with_values(reader: 1, collaborator: 2, editor: 3, admin: 4) }
end
