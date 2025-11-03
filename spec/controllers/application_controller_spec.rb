require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:workspace) { create(:workspace) }
  let(:user) { create(:user, workspace: nil) }

  describe "#after_sign_in_path_for" do
    it "redirects to the create new workspace route if user doesn't belong to a workspace" do
      expect(subject.after_sign_in_path_for(user)).to eq(new_workspace_path)
    end

    it "redirects to the app route if user has workspace" do
      user.update(workspace: workspace)

      expect(subject.after_sign_in_path_for(user)).to eq(app_root_path(workspace.subdomain))
    end

  end
end