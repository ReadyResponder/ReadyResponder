require 'spec_helper'

describe "helpdocs/new" do
  before(:each) do
    assign(:helpdoc, stub_model(Helpdoc,
      :title => "MyString",
      :contents => "MyText",
      :help_for_view => "MyString",
      :help_for_section => "MyString"
    ).as_new_record)
  end

  it "renders new helpdoc form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => helpdocs_path, :method => "post" do
      assert_select "input#helpdoc_title", :name => "helpdoc[title]"
      assert_select "textarea#helpdoc_contents", :name => "helpdoc[contents]"
      assert_select "input#helpdoc_help_for_view", :name => "helpdoc[help_for_view]"
      assert_select "input#helpdoc_help_for_section", :name => "helpdoc[help_for_section]"
    end
  end
end
