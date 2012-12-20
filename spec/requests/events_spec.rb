require 'spec_helper'

describe "Events" do
  before (:each)  do
    somebody = FactoryGirl.create(:user)
    r = FactoryGirl.create(:role, name: 'Editor')
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end
  describe "GET /events" do
    it "works! " do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit events_path
      page.should have_content("Listing Events")
    end
  end
end
