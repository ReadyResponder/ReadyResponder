require 'spec_helper'

describe "messages/index" do
  before(:each) do
    assign(:messages, [
      stub_model(Message,
        :subject => "Subject",
        :status => "Status",
        :body => "Body",
        :channels => "Channels",
        :created_by => 1
      ),
      stub_model(Message,
        :subject => "Subject",
        :status => "Status",
        :body => "Body",
        :channels => "Channels",
        :created_by => 1
      )
    ])
  end

  it "renders a list of messages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Body".to_s, :count => 2
    assert_select "tr>td", :text => "Channels".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
