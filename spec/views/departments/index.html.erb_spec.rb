require 'rails_helper'

RSpec.describe "departments/index", :type => :view do
  before(:each) do
    assign(:departments, [
      Department.create!(
        :name => "Name",
        :status => "Status",
        :contact_id => 1,
        :description => "MyText",
        :manage_people => false,
        :manage_items => true
      ),
      Department.create!(
        :name => "Name",
        :status => "Status",
        :contact_id => 1,
        :description => "MyText",
        :manage_people => true,
        :manage_items => false
      )
    ])
  end

  it "renders a list of departments" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "true".to_s, :count => 2
    assert_select "tr>td", :text => "false".to_s, :count => 2
  end
end
