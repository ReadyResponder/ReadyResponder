require 'rails_helper'

RSpec.describe "resource_types/edit", :type => :view do
  before(:each) do
    @resource_type = assign(:resource_type, ResourceType.create!(
      :name => "MyString",
      :status => "MyString",
      :description => "MyText",
      :fema_code => "MyString",
      :fema_kind => "MyString"
    ))
  end

  it "renders the edit resource_type form" do
    render

    assert_select "form[action=?][method=?]", resource_type_path(@resource_type), "post" do

      assert_select "input#resource_type_name[name=?]", "resource_type[name]"

      assert_select "select#resource_type_status[name=?]", "resource_type[status]"

      assert_select "textarea#resource_type_description[name=?]", "resource_type[description]"

      assert_select "input#resource_type_fema_code[name=?]", "resource_type[fema_code]"

      assert_select "input#resource_type_fema_kind[name=?]", "resource_type[fema_kind]"
    end
  end
end
