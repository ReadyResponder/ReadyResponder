require 'rails_helper'

RSpec.describe "departments/edit", :type => :view do
  before(:each) do
    @department = assign(:department, Department.create!(
      :name => "MyString",
      :status => "MyString",
      :contact_id => 1,
      :description => "MyText"
    ))
  end

  it "renders the edit department form" do
    render

    assert_select "form[action=?][method=?]", department_path(@department), "post" do

      assert_select "input#department_name[name=?]", "department[name]"

      assert_select "select#department_status[name=?]", "department[status]"

      assert_select "select#department_contact_id[name=?]", "department[contact_id]"

      assert_select "textarea#department_description[name=?]", "department[description]"
    end
  end
end
