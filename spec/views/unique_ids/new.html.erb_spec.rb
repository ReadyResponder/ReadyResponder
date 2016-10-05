require 'rails_helper'

RSpec.describe "unique_ids/new", :type => :view do
  before(:each) do
    assign(:unique_id, UniqueId.new(
      :item => nil,
      :status => "MyString",
      :category => "MyString",
      :value => "MyString"
    ))
  end

  it "renders new unique_id form" do
    render
      assert_select "form[action=?][method=?]", unique_ids_path, "post" do
      assert_select "select#unique_id_item_id[name=?]", "unique_id[item_id]"
      assert_select "input#unique_id_status[name=?]", "unique_id[status]"
      assert_select "input#unique_id_category[name=?]", "unique_id[category]"
      assert_select "input#unique_id_value[name=?]", "unique_id[value]"
    end
  end
end
