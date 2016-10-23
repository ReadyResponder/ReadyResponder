require 'rails_helper'

RSpec.describe "Roles" do
  before (:each) { sign_in_as('Editor') }

  describe "GET /roles" do
    it "works!" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit roles_path
      expect(page).to have_content("Listing Roles")
    end
  end
end
