require 'rails_helper'

RSpec.describe "Base", type: :request do
  let(:workspace) { create(:workspace, subdomain: "alpha") }
  let(:workspace_beta) { create(:workspace, name: "Beta", subdomain: "beta") }
  let(:user_without_workspace) { create(:user, workspace: nil, role: nil) }
  let(:user_with_workspace) { create(:user, workspace: workspace, role: :admin) }

  context "when user has no workspace" do
    before { sign_in user_without_workspace }

    describe "GET /:subdomain/app" do
      it "should redirect user to create a new workspace" do
        get app_root_path(workspace.subdomain)

        expect(response).to redirect_to(new_workspace_path)
      end
    end
  end

  context "when user belong to a workspace" do
    before { sign_in user_with_workspace }

    describe "GET /:subdomain/app" do
      it "redirects a user trying to access another workspace back to their own" do
        get app_root_path(workspace_beta.subdomain)

        expect(response).to redirect_to(app_root_path(user_with_workspace.workspace.subdomain))
      end

      it "allows access" do
        get app_root_path(workspace.subdomain)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
