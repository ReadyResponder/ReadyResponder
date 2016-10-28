require 'rails_helper'

RSpec.describe Item do
  before(:each) { sign_in_as('Editor') }

  it "a new item form with appropriate fields" do
    visit new_item_path
    fill_in('item_model', :with => 'Model T')
    expect(find_field('item_status').value).to have_content('Available')
  end

  it "an edit form with values filled in" do
    @item = create(:item)
    visit edit_item_path(@item)
    expect(page).to have_field("item_model", :with => @item.model)
  end

  it "a new item form with proper departments filled in" do
    @department1 = Department.create(name: "Manages items", manage_items: true)
    Department.create(name: "Doesn't manage items", manage_items: false)
    visit new_item_path
    expect(page).to have_select("item_department_id", :options => [@department1.name, ''])
  end

  get_basic_editor_views('item',['name', 'description', 'status'])
end
