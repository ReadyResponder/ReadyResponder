require 'rails_helper'

RSpec.describe "unique_ids/edit", :type => :view do
  before(:each) do
    @unique_id = assign(:unique_id, UniqueId.create!(
      :item => nil,
      :status => "MyString",
      :category => "MyString",
      :value => "MyString"
    ))
  end

  it "renders the edit unique_id form" do
    render

    assert_select "form[action=?][method=?]", unique_id_path(@unique_id), "post" do

      assert_select "select#unique_id_item_id[name=?]", "unique_id[item_id]"

      assert_select "input#unique_id_status[name=?]", "unique_id[status]"

      assert_select "input#unique_id_category[name=?]", "unique_id[category]"

      assert_select "input#unique_id_value[name=?]", "unique_id[value]"
    end
  end
end
