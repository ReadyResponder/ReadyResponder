require 'rails_helper'

RSpec.describe "resourcetypes/new", :type => :view do
  before(:each) do
    assign(:resourcetype, Resourcetype.new(
      :name => "MyString",
      :femakind => "MyString",
      :femacode => "MyString",
      :status => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new resourcetype form" do
    render

    assert_select "form[action=?][method=?]", resourcetypes_path, "post" do

      assert_select "input#resourcetype_name[name=?]", "resourcetype[name]"

      assert_select "input#resourcetype_femakind[name=?]", "resourcetype[femakind]"

      assert_select "input#resourcetype_femacode[name=?]", "resourcetype[femacode]"

      assert_select "input#resourcetype_status[name=?]", "resourcetype[status]"

      assert_select "textarea#resourcetype_description[name=?]", "resourcetype[description]"
    end
  end
end
