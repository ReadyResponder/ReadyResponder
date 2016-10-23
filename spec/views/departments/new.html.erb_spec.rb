require 'rails_helper'

RSpec.describe "departments/new", :type => :view do
  before(:each) do
    assign(:department, Department.new(
      :name => "MyString",
      :status => "MyString",
      :contact_id => 1,
      :description => "MyText",
      :manage_people => false,
      :manage_items => true
    ))
  end

  it "renders new department form" do
    render

    assert_select "form[action=?][method=?]", departments_path, "post" do

      assert_select "input#department_name[name=?]", "department[name]"

      assert_select "select#department_status[name=?]", "department[status]"

      assert_select "select#department_contact_id[name=?]", "department[contact_id]"

      assert_select "textarea#department_description[name=?]", "department[description]"

      assert_select "input#department_manage_people[name=?]", "department[manage_people]"

      assert_select "input#department_manage_items[name=?]", "department[manage_items]"
    end
  end
end
