require 'rails_helper'

RSpec.describe "item_types/new", :type => :view do
  before(:each) do
    assign(:item_type, ItemType.new(
      :name => "MyString",
      :status => "Active",
      :is_groupable => "MyString",
      :is_a_group => "MyString",
      :parent_id => 1
    ))
  end

  it "renders new item_type form" do
    render

    assert_select "form[action=?][method=?]", item_types_path, "post" do
      assert_select "input#item_type_name[name=?]", "item_type[name]"
      assert_select "select#item_type_status[name=?]", "item_type[status]"
      assert_select "input#item_type_is_groupable[name=?]", "item_type[is_groupable]"
      assert_select "input#item_type_is_a_group[name=?]", "item_type[is_a_group]"
      assert_select "input#item_type_parent_id[name=?]", "item_type[parent_id]"
    end
  end
end
