require 'rails_helper'

RSpec.describe "Repairs" do
  let!(:item) { create(:item) }
  let!(:person) { create(:person) }
  let!(:repair) { create(:repair) }
  before(:each) { sign_in_as('Editor') }

  describe "GET /repairs" do
    it "returns a page" do
      visit repairs_path
      expect(page).to have_content("Listing Repairs")
      expect(page).to have_content("Home") # This is in the nav bar
    end
  end

  describe "GET /item_categories" do
    it "will display items need to repair" do
      visit item_categories_path
      expect(page).to have_content "Repairs"
      expect(page).to have_css "table"
    end
  end
end
