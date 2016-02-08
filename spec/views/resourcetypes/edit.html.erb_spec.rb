require 'rails_helper'

RSpec.describe "resourcetypes/edit", :type => :view do
  before(:each) do
    @resourcetype = assign(:resourcetype, Resourcetype.create!(
      :name => "MyString",
      :femakind => "MyString",
      :femacode => "MyString",
      :status => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit resourcetype form" do
    render

    assert_select "form[action=?][method=?]", resourcetype_path(@resourcetype), "post" do

      assert_select "input#resourcetype_name[name=?]", "resourcetype[name]"

      assert_select "input#resourcetype_femakind[name=?]", "resourcetype[femakind]"

      assert_select "input#resourcetype_femacode[name=?]", "resourcetype[femacode]"

      assert_select "input#resourcetype_status[name=?]", "resourcetype[status]"

      assert_select "textarea#resourcetype_description[name=?]", "resourcetype[description]"
    end
  end
end
