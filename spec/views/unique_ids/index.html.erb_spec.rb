require 'rails_helper'

RSpec.describe "unique_ids/index", :type => :view do
  before(:each) do
    assign(:unique_ids, [
      UniqueId.create!(
        :item => nil,
        :status => "Status",
        :category => "Category",
        :value => "Value"
      ),
      UniqueId.create!(
        :item => nil,
        :status => "Status",
        :category => "Category",
        :value => "Value"
      )
    ])
  end

  it "renders a list of unique_ids" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
  end
end
