require 'rails_helper'

RSpec.describe "departments/index", :type => :view do
  let(:user) { FactoryGirl.create :user }
  before(:each) do
    assign(:departments, [
      Department.create!(
        :name => "Red Cross",
        :shortname => "Red Cross",
        :status => "Active",
        :description => "MyText",
        :manage_people => false,
        :manage_items => true
      ),
      Department.create!(
        :name => "MRC",
        :shortname => "Red Cross",
        :status => "Active",
        :description => "MyText",
        :manage_people => true,
        :manage_items => false
      )
    ])
    allow(controller).to receive(:current_user).and_return(user)
  end

  it "renders a list of departments" do
    render
    assert_select "tr>td", :text => "Red Cross".to_s, :count => 1
    assert_select "tr>td", :text => "Active".to_s, :count => 2
    assert_select "tr>td", :text => "true".to_s, :count => 2
    assert_select "tr>td", :text => "false".to_s, :count => 2
  end
end
