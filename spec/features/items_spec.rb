require 'rails_helper'

RSpec.describe Item do
  let!(:item_category) { create(:item_category) }
  let!(:item_type) { create(:item_type, :item_category => item_category)}

  before(:each) do
    sign_in_as('Editor')

    allow_any_instance_of(Item).to receive(:item_type).and_return(item_type)
  end

  it "a new item form with appropriate fields" do
    visit new_item_type_item_path(item_type)
    fill_in('item_model', :with => 'Model T')
    expect(find_field('item_status').value).to have_content('Unassigned')
  end

  it "an edit form with values filled in" do
    @item = create(:item, :item_type => item_type)
    visit edit_item_type_item_path(item_type, @item)
    expect(page).to have_field("item_model", :with => @item.model)
  end

  it "a new item form with proper departments filled in" do
    department_yes = Department.create(name: "Manages items", shortname: "Manages items", manage_items: true)
    department_no = Department.create(name: "Doesn't manage items", shortname: "Doesn't", manage_items: false)
    visit new_item_type_item_path(item_type)
    expect(page).to have_select("item_department_id", :options => [department_yes.name, ''])
    expect(page).to_not have_select("item_department_id", :options => [department_no.name, ''])
  end

end
