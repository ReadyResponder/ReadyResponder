require 'spec_helper'

describe "messages/show" do
  before(:each) do
    @message = assign(:message, stub_model(Message,
      :subject => "Subject",
      :status => "Status",
      :body => "Body",
      :channels => "Channels",
      :created_by => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Subject/)
    rendered.should match(/Status/)
    rendered.should match(/Body/)
    rendered.should match(/Channels/)
    rendered.should match(/1/)
  end
end
