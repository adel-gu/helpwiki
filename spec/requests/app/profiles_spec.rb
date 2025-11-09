require 'rails_helper'

RSpec.describe "App::Profiles", type: :request do
  let(:workspace) { create(:workspace) }
  let(:user) { create(:user, workspace: workspace, password: "old_password") }

  before { sign_in user }

  describe "edit profile" do
    it "render edit profile view" do
      get edit_app_profile_path(workspace.subdomain)

      expect(response).to render_template(:edit)
    end

    it "update user profile info" do
      patch app_profile_path(workspace.subdomain),
        params: { user: { full_name: "new user" } }

      expect(response).to redirect_to(edit_app_profile_path(workspace.subdomain))
      follow_redirect!

      expect(response).to render_template(:edit)
      expect(response.body).to include("Your profile has been updated.")
    end

    it "doesn't update when full_name is blank" do
      patch app_profile_path(workspace.subdomain),
        params: { user: { full_name: "" } }

      expect(response).to have_http_status(:unprocessable_content)
      expect(response.body).to include("h")
    end
  end

  describe "edit security" do
    let(:password_update_path) { update_password_app_profile_path(workspace.subdomain) }

    it "render security template" do
      get security_app_profile_path(workspace.subdomain)

      expect(response).to render_template(:security)
    end

    context "with valid params" do
      it "should update user security info" do
        patch password_update_path,
          params: { user: { current_password: "old_password", password: "password123", password_confirmation: "password123" } }

        expect(response).to redirect_to(security_app_profile_path(workspace.subdomain))
        follow_redirect!

        expect(response.body).to include("Your password has been updated successfully.")

        # Check the bypass_sign_in
        get app_root_path(workspace.subdomain)
        expect(response).not_to redirect_to(new_user_session_path)
      end
    end

    context "with invalid params" do
      it "should not update user security info" do
        patch password_update_path,
          params: { user: { current_password: "new_password", password: "password123", password_confirmation: "password123" } }

        expect(response).to have_http_status(:unprocessable_content)
        expect(response).to render_template(:security)
        expect(response.body).to include("Current password is invalid")
      end
    end
  end
end
