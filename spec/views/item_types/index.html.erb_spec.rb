require 'rails_helper'

RSpec.describe "item_types/index", :type => :view do
  let(:user) { FactoryGirl.create :user }
  let!(:item_category) { FactoryGirl.create :item_category}
  before(:each) do
    assign(:item_types, [
      ItemType.create!(
        :name => "Truck",
        :status => "Active",
        :is_groupable => false,
        :item_category_id => item_category.id
      ),
      ItemType.create!(
        :name => "Radio",
        :status => "Active",
        :is_groupable => false,
        :is_a_group => false,
        :item_category_id => item_category.id
      )
    ])
    allow(controller).to receive(:current_user).and_return(user)
  end

  it "renders a list of item_types" do
    render
    assert_select "tr>td", :text => "Truck", :count => 1
    assert_select "tr>td", :text => "Active", :count => 2
  end
end
