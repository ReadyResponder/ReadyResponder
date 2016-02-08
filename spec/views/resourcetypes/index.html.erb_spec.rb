require 'rails_helper'

RSpec.describe "resourcetypes/index", :type => :view do
  before(:each) do
    assign(:resourcetypes, [
      Resourcetype.create!(
        :name => "Name",
        :femakind => "Femakind",
        :femacode => "Femacode",
        :status => "Status",
        :description => "MyText"
      ),
      Resourcetype.create!(
        :name => "Name",
        :femakind => "Femakind",
        :femacode => "Femacode",
        :status => "Status",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of resourcetypes" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Femakind".to_s, :count => 2
    assert_select "tr>td", :text => "Femacode".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
