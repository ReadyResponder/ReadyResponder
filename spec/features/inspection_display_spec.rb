require 'rails_helper'
#Don't use capybara (ie visit/have_content) and rspec matchers together  {response.status.should be(200)}

RSpec.describe "Inspection" do
  let!(:item_category) { create(:item_category) }
  let!(:item_type) { create(:item_type, :item_category => item_category)}

  before(:each) do
    sign_in_as('Editor')

    allow_any_instance_of(Item).to receive(:item_type).and_return(item_type)
  end

  describe "when not logged in" do
    let(:an_item)  { create(:item) }
    let(:an_inspection) { create(:inspection, item: an_item) }
    it "should not display a listing" do
      click_on 'Sign Out'
      visit inspections_path
      expect(page).not_to have_css("nav.navbar")
      expect(page).not_to have_content("New Inspection")
      expect(page).to have_content('You need to sign in')
      visit edit_inspection_path(an_inspection)
      expect(page).to have_content('You need to sign in')
    end
  end
  describe "should have a form" do
    pending "Need tests for inspection forms"
  end

  context "on an item" do
    let(:an_item)  { create(:item) }
    let(:an_inspection) { create(:inspection, item: an_item) }
    it "should show an inspection" do
      visit inspection_path(an_inspection)
      expect(page).to have_content(an_inspection.status)
    end
  end

  context "on item index" do
    let(:an_item) { create(:item, item_type_id: 1) }
    let!(:an_inspection) { create(:inspection, item: an_item, inspection_date: 1.day.ago) }
    let!(:an_older_inspection) { create(:inspection, item: an_item, inspection_date: 2.days.ago) }
    it "should show last inspection date" do
      visit item_type_path(an_item.item_type_id)
      expect(page).to have_content(an_inspection.inspection_date)
      expect(page).not_to have_content(an_older_inspection.inspection_date)
    end
  end

  context "from an item" do
    let!(:item)  { create(:item) }
    it "should create an inspection for that item" do
      visit item_path(item)
      expect(page).to have_content('Description:')
      within("#sidebar") do
        expect(page).to have_content('Add Inspection')
      end
      click_on 'Add Inspection'
      expect(page).to have_content('Inspection date')
      fill_in 'Inspection date', with: Date.tomorrow.strftime('%Y-%m-%d')
      fill_in 'Comments', with: 'We should inspect this item.'
      click_on 'Create Inspection'
      expect(current_path).to eq item_path(item)
      within("#flash_notice") do
        expect(page).to have_content "Inspection was successfully created."
      end
    end
  end
end
