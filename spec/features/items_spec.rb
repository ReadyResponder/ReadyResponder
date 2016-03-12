require 'spec_helper'

describe Item do
  before (:each) do
    somebody = create(:user)
    r = create(:role, name: 'Editor')
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end

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

  get_basic_editor_views('item',['name', 'description', 'status'])
end
