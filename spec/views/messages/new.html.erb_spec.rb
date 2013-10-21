require 'spec_helper'

describe "messages/new" do
  before(:each) do
    assign(:message, stub_model(Message,
      :subject => "MyString",
      :status => "MyString",
      :body => "MyString",
      :channels => "MyString",
      :created_by => 1
    ).as_new_record)
  end

  it "renders new message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => messages_path, :method => "post" do
      assert_select "input#message_subject", :name => "message[subject]"
      assert_select "input#message_status", :name => "message[status]"
      assert_select "input#message_body", :name => "message[body]"
      assert_select "input#message_channels", :name => "message[channels]"
      assert_select "input#message_created_by", :name => "message[created_by]"
    end
  end
end
