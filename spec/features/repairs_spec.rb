require 'spec_helper'

describe "Repairs" do
  before (:each)  do
    somebody = create(:user)
    r = create(:role, name: 'Editor')
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end

  describe "GET /repairs" do
    it "returns a page" do
      visit repairs_path
      expect(page).to have_content("Listing Repairs")
      expect(page).to have_content("Home") # This is in the nav bar
    end
  end
end
