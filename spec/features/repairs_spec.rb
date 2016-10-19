require 'rails_helper'

RSpec.describe "Repairs" do
  before(:each) { sign_in_as('Editor') }

  describe "GET /repairs" do
    it "returns a page" do
      visit repairs_path
      expect(page).to have_content("Listing Repairs")
      expect(page).to have_content("Home") # This is in the nav bar
    end
  end
end
