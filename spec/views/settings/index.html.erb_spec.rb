require 'rails_helper'

RSpec.describe "settings/index", type: :view do
  let(:user) { FactoryGirl.create :user }
  before(:each) do
    assign(:settings, [
      Setting.create!(name: "User Name",
                      key: "username",
                      value: "John Doe",
                      category: "authentication",
                      status: "Active")
    ])
    allow(controller).to receive(:current_user).and_return(user)
  end

  it "renders a list of settings" do
    render
    assert_select "tr>td", :text => "username", :count => 1
  end
end
