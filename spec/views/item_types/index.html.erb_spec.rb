require 'rails_helper'

RSpec.describe "item_types/index", :type => :view do
  before(:each) do
    assign(:item_types, [
      ItemType.create!(
        :name => "Name",
        :status => "Status",
        :is_groupable => "Is Groupable",
        :is_a_group => "Is A Group",
        :parent_id => 1
      ),
      ItemType.create!(
        :name => "Name",
        :status => "Status",
        :is_groupable => "Is Groupable",
        :is_a_group => "Is A Group",
        :parent_id => 1
      )
    ])
  end

  it "renders a list of item_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Is Groupable".to_s, :count => 2
    assert_select "tr>td", :text => "Is A Group".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
