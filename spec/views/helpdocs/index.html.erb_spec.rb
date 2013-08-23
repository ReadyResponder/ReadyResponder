require 'spec_helper'

describe "helpdocs/index" do
  before(:each) do
    assign(:helpdocs, [
      stub_model(Helpdoc,
        :title => "Title",
        :contents => "MyText",
        :help_for_view => "Help For View",
        :help_for_section => "Help For Section"
      ),
      stub_model(Helpdoc,
        :title => "Title",
        :contents => "MyText",
        :help_for_view => "Help For View",
        :help_for_section => "Help For Section"
      )
    ])
  end

  it "renders a list of helpdocs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Help For View".to_s, :count => 2
    assert_select "tr>td", :text => "Help For Section".to_s, :count => 2
  end
end
