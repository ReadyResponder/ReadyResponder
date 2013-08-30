require 'spec_helper'

describe "activities/new" do
  before(:each) do
    assign(:activity, stub_model(Activity,
      :content => "MyString",
      :author => "MyString",
      :loggable_id => 1,
      :loggable_type => "MyString"
    ).as_new_record)
  end

  it "renders new activity form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => activities_path, :method => "post" do
      assert_select "input#activity_content", :name => "activity[content]"
      assert_select "input#activity_author", :name => "activity[author]"
      assert_select "input#activity_loggable_id", :name => "activity[loggable_id]"
      assert_select "input#activity_loggable_type", :name => "activity[loggable_type]"
    end
  end
end
