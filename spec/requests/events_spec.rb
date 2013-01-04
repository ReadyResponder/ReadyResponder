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
  describe "events" do
    it "displays a listing" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit events_path
      page.should have_content("Listing Events")
      page.should have_css('#sidebar')
      within_table("events") do
	within("tbody") do
	  #pending page.should have_css("td")  # this is only picking up the edit button at the end, not an event show link
	end
      end
    end
    
    it "displays a single event" do
      e = FactoryGirl.create(:event)
      visit event_path(e)
      page.should have_css('#sidebar')
    end
  end
end
