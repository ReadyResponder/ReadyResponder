require 'rails_helper'

RSpec.describe "item_types/new", :type => :view do
  let!(:item_category) { FactoryGirl.create :item_category}

  before(:each) do
    assign(:item_type, ItemType.new(
      :name => "MyString",
      :status => "Active",
      :item_category_id => item_category.id
    ))
  end

  it "renders new item_type form" do
    render

    assert_select "form[action=?][method=?]", item_types_path, "post" do
      assert_select "input#item_type_name[name=?]", "item_type[name]"
      assert_select "select#item_type_status[name=?]", "item_type[status]"
    end
  end
end
