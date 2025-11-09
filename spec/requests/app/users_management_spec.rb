require 'rails_helper'

RSpec.describe "App::UsersManagements", type: :request do
  let(:workspace) { create(:workspace) }
  let(:admin) { create(:user, workspace: workspace, role: :admin) }
  let(:reader) { create(:user, workspace: workspace, role: :reader) }

  context "all roles" do
    describe "GET /:subdomain/app/users_management" do
      before do
        sign_in admin
        sign_in reader
      end

      it "should render user management table" do
        get app_users_management_index_path(workspace.subdomain)

        expect(response).to render_template(:index)
        expect(response.body).to include(admin.full_name)
        expect(response.body).to include(reader.full_name)
      end
    end
  end

  context "admin" do
    describe "users management" do
      before { sign_in admin }

      it "should render the new template" do
        get new_app_users_management_path(workspace.subdomain)

        expect(response).to render_template(:new)
      end

      it "should sent an invitation" do
        expect {
          post app_users_management_index_path(workspace.subdomain),
            params: { user: { email: "example@gmail.com", role: :editor }}
        }.to change(User, :count).by(1)

        new_user = User.find_by(email: "example@gmail.com")
        expect(new_user).to be_present
        expect(new_user.invitation_token).to be_present
        expect(new_user.workspace).to eq(workspace)

        expect(response).to redirect_to(app_users_management_index_path(workspace.subdomain))
        follow_redirect!

        expect(response.body).to include("Invitation sent to #{new_user.email}")
      end

      it "should not sent an invitation" do
        post app_users_management_index_path(workspace.subdomain),
          params: { user: { email: "", role: :editor }}

        expect(response).to have_http_status(:unprocessable_content)
        expect(response).to render_template(:new)

        expect(flash[:alert]).to include("Email can't be blank")
      end

      it "should update reader role" do
        patch app_users_management_path(workspace.subdomain, reader),
          params: { user: { role: "collaborator" }}

        expect(response).to redirect_to(app_users_management_index_path(workspace.subdomain))
        follow_redirect!

        reader.reload
        expect(reader.role).to eq("collaborator")
        expect(response.body).to include("User role updated successfully.")
      end

      it "should delete reader" do
        delete app_users_management_path(workspace.subdomain, reader.id)

        expect(workspace.users.exists?(reader.id)).to be false
        expect(response).to redirect_to(app_users_management_index_path(workspace.subdomain))
        follow_redirect!
        expect(response.body).to include("User removed successfully.")
      end
    end
  end

  context "non admin" do
    describe "users management" do
      before { sign_in reader }

      it "should not render the new template" do
        get new_app_users_management_path(workspace.subdomain)

        expect(response).to redirect_to(app_root_path(workspace.subdomain))
        follow_redirect!

        expect(response.body).to include("You are not authorized to perform this action")
      end

      it "should not sent an invitation" do
        post app_users_management_index_path(workspace.subdomain),
          params: { user: { email: "example@gmail.com", role: :editor }}

        expect(response).to redirect_to(app_root_path(workspace.subdomain))
        follow_redirect!
        expect(response.body).to include("You are not authorized to perform this action")
      end

      it "should not update reader role" do
        patch app_users_management_path(workspace.subdomain, reader),
          params: { user: { role: "collaborator" }}

        expect(response).to redirect_to(app_root_path(workspace.subdomain))
        follow_redirect!
        expect(response.body).to include("You are not authorized to perform this action")
      end

      it "should delete reader" do
        delete app_users_management_path(workspace.subdomain, reader.id)

        expect(workspace.users.exists?(reader.id)).to be true
        expect(response).to redirect_to(app_root_path(workspace.subdomain))
        follow_redirect!
        expect(response.body).to include("You are not authorized to perform this action")
      end
    end
  end
end
