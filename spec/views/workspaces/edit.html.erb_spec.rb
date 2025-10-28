require 'rails_helper'

RSpec.describe "workspaces/edit", type: :view do
  let(:workspace) {
    Workspace.create!(
      name: "MyString",
      subdomain: "MyString"
    )
  }

  before(:each) do
    assign(:workspace, workspace)
  end

  it "renders the edit workspace form" do
    render

    assert_select "form[action=?][method=?]", workspace_path(workspace), "post" do

      assert_select "input[name=?]", "workspace[name]"

      assert_select "input[name=?]", "workspace[subdomain]"
    end
  end
end
