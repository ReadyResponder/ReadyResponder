require 'rails_helper'

RSpec.describe "item_categories/edit", type: :view do
  before(:each) do
    @item_category = assign(:item_category, ItemCategory.create!(
      :name => "Thing",
      :status => "Active",
      :description => "MyString"
    ))
  end

  it "renders the edit item_category form" do
    render

    assert_select "form[action=?][method=?]", item_category_path(@item_category), "post" do

      assert_select "input#item_category_name[name=?]", "item_category[name]"

      assert_select "select#item_category_status[name=?]", "item_category[status]"

      assert_select "#item_category_description[name=?]", "item_category[description]"

    end
  end
end
