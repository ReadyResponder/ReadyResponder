require 'rails_helper'

RSpec.describe "resource_types/index", :type => :view do
  let(:user) { FactoryGirl.create :user }
  before(:each) do
    assign(:resource_types, [
      ResourceType.create!(
        :name => "Name",
        :status => "Active",
        :description => "MyText",
        :fema_code => "Fema Code",
        :fema_kind => "Fema Kind"
      ),
      ResourceType.create!(
        :name => "Name2",
        :status => "Active",
        :description => "MyText",
        :fema_code => "Fema Code2",
        :fema_kind => "Fema Kind"
      )
    ])
    allow(controller).to receive(:current_user).and_return(user)
  end

  it "renders a list of resource_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 1
    assert_select "tr>td", :text => "Name2".to_s, :count => 1
    assert_select "tr>td", :text => "Active", :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Fema Code".to_s, :count => 1
    assert_select "tr>td", :text => "Fema Code2".to_s, :count => 1
    assert_select "tr>td", :text => "Fema Kind".to_s, :count => 2
  end
end
