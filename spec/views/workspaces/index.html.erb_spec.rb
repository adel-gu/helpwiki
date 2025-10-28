require 'rails_helper'

RSpec.describe "workspaces/index", type: :view do
  before(:each) do
    assign(:workspaces, [
      Workspace.create!(
        name: "Name",
        subdomain: "Subdomain"
      ),
      Workspace.create!(
        name: "Name",
        subdomain: "Subdomain"
      )
    ])
  end

  it "renders a list of workspaces" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Subdomain".to_s), count: 2
  end
end
