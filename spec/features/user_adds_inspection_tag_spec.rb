require 'rails_helper'

# As an editor
# When I visit the inspection tags page
# And I click "add tag"
# And I fill in the tag name
# And I click submit
# Then I should see the tag in the tag list
# And it should be available in item_categories
# And it should be available in item_types

RSpec.feature "Editor submits a tag" do
  scenario "they see the tag added to the tag list" do
    sign_in_as('Admin')

    visit new_inspection_tag_path
    fill_in('inspection_tag_name', with: "PoppinTags")
    click_button('Create Inspection tag')
    expect(page).to have_content("PoppinTags")
  end

  scenario "they are alerted the tag already exists" do
    tag = create(:inspection_tag)
    sign_in_as('Admin')

    visit new_inspection_tag_path
    fill_in('inspection_tag_name', with: tag.name)
    click_button('Create Inspection tag')
    expect(page).to have_selector(".field_with_errors")
  end
end
