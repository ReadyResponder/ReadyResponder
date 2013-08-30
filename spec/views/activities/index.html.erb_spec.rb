require 'spec_helper'

describe "activities/index" do
  before(:each) do
    assign(:activities, [
      stub_model(Activity,
        :content => "Content",
        :author => "Author",
        :loggable_id => 1,
        :loggable_type => "Loggable Type"
      ),
      stub_model(Activity,
        :content => "Content",
        :author => "Author",
        :loggable_id => 1,
        :loggable_type => "Loggable Type"
      )
    ])
  end

  it "renders a list of activities" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Content".to_s, :count => 2
    assert_select "tr>td", :text => "Author".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Loggable Type".to_s, :count => 2
  end
end
