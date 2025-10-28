require 'rails_helper'

RSpec.describe "workspaces/show", type: :view do
  before(:each) do
    assign(:workspace, Workspace.create!(
      name: "Name",
      subdomain: "Subdomain"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Subdomain/)
  end
end
