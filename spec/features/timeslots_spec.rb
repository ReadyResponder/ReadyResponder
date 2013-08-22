require 'spec_helper'
#save_and_open_page
describe 'Access on timeslot' do
  it "gets denied" do
    visit timeslots_path
    page.should have_content("need to sign in")
    visit new_timeslot_path
    page.should have_content("need to sign in")
    @sample_object = FactoryGirl.create(:timeslot)
    visit url_for(@sample_object)
    page.should have_content("need to sign in")
  end
end

describe "timeslot" do
  before (:each) do
    somebody = FactoryGirl.create(:user)
    r = FactoryGirl.create(:role, name: "Editor")
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end

  it "gets the index" do
    @sample_object = FactoryGirl.create(:timeslot)
    visit timeslots_path
    page.should have_content("LIMS") # In the nav bar
    page.should have_css('#sidebar')
    page.should have_content("Listing Timeslots")
    page.should have_content(@sample_object.category)
  end
  it "visits a creation form" do
    @sample_object = FactoryGirl.create(:timeslot)
    visit new_timeslot_path
    page.should have_content("LIMS")
    page.should have_css('#sidebar')
    page.should have_content('Category')
    page.should have_content("New Timeslot")
  end
  it "visits a display page" do
    @sample_object = FactoryGirl.create(:timeslot)
    visit url_for(@sample_object)
    page.should have_content("LIMS")
    page.should have_css('#sidebar')
    page.should have_content(@sample_object.category)
    page.should have_content(@sample_object.intention)
  end
  it "visits a display page without actual times" do
    @sample_object = FactoryGirl.create(:timeslot, actual_start_time: nil, actual_end_time: nil)
    visit url_for(@sample_object)
    page.should have_content("LIMS")
    page.should have_css('#sidebar')
    page.should have_content(@sample_object.category)
    page.should have_content(@sample_object.intention)
  end
end