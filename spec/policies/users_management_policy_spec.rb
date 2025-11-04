require 'rails_helper'

RSpec.describe UsersManagementPolicy, type: :policy do
  subject { described_class }

  let(:workspace) { build(:workspace) }

  let(:admin)  { build(:user, role: :admin, workspace: workspace) }
  let(:reader) { build(:user, role: :reader, workspace: workspace) }

  let(:record) { build(:user, workspace: workspace) }

  permissions :new?, :create?, :update?, :destroy? do
    context "when user is an admin" do
      it "grants access" do
        expect(subject).to permit(admin, record)
      end
    end

    context "when user is not an admin" do
      it "denies access" do
        expect(subject).not_to permit(reader, record)
      end
    end
  end
end
