require 'rails_helper'

RSpec.describe "item_types/edit", :type => :view do
  let!(:item_category) { FactoryBot.create :item_category}

  before(:each) do
    @item_type = assign(:item_type, ItemType.create!(
      :name => "MyString",
      :status => "Active",
      :item_category_id => item_category.id
    ))
  end

  it "renders the edit item_type form" do
    render

    assert_select "form[action=?][method=?]", item_type_path(@item_type), "post" do
      assert_select "input#item_type_name[name=?]", "item_type[name]"
      assert_select "select#item_type_status[name=?]", "item_type[status]"
    end
  end
end
