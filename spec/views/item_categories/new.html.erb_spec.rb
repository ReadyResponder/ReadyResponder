require 'rails_helper'

RSpec.describe "item_categories/new", type: :view do
  before(:each) do
    assign(:item_category, ItemCategory.new(
      :name => "MyString",
      :status => "MyString",
      :description => "MyString",
      :department => nil
    ))
  end

  it "renders new item_category form" do
    render

    assert_select "form[action=?][method=?]", item_categories_path, "post" do

      assert_select "input#item_category_name[name=?]", "item_category[name]"

      assert_select "select#item_category_status[name=?]", "item_category[status]"

      assert_select "#item_category_description[name=?]", "item_category[description]"

      assert_select "select#item_category_department_id[name=?]", "item_category[department_id]"
    end
  end
end
