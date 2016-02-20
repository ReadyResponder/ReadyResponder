require 'spec_helper'
#Don't use capybara (ie visit/have_content) and rspec matchers together  {response.status.should be(200)}

describe "Inspection" do
  before (:each)  do
    somebody = create(:user)
    r = create(:role, name: 'Editor')
    somebody.roles << r

    visit new_user_session_path
    fill_in('user_email', :with => somebody.email)
    fill_in('user_password', :with => somebody.password)
    click_on 'Sign in'
  end
  describe "when not logged in" do
    it "should not display a listing" do
      click_on 'Sign Out'
      visit inspections_path
      expect(page).not_to have_css("div.navbar")
      expect(page).not_to have_content("New Item")
      expect(page).to have_content('You need to sign in')
      visit new_inspection_path
      expect(page).to have_content('You need to sign in')
      an_inspection = create(:inspection)
      visit edit_inspection_path(an_inspection)
      expect(page).to have_content('You need to sign in')
    end
  end
  describe "should have a form" do
    pending "Need tests for inspection forms"
  end

  context "on an item" do
    it "should show an inspection" do
      an_inspection = create(:inspection,
                                         :item => create(:item))
      visit inspection_path(an_inspection)
      expect(page).to have_content(an_inspection.status)
    end
  end
end
