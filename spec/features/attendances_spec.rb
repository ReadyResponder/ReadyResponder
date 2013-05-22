require 'spec_helper'
#save_and_open_page
describe 'Access on Attendance' do
  it "gets denied" do
    visit attendances_path
    page.should have_content("need to sign in")
    visit new_attendance_path
    page.should have_content("need to sign in")
    @sample_object = FactoryGirl.create(:attendance)
    visit url_for(@sample_object)
    page.should have_content("need to sign in")
  end
end
describe "Attendance" do
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
    @sample_object = FactoryGirl.create(:attendance)
    visit attendances_path
    page.should have_content("LIMS") # In the nav bar
    page.should have_css('#sidebar')
    page.should have_content("Listing Attendances")
    page.should have_content(@sample_object.category)
  end
  it "visits a creation form" do
    @sample_object = FactoryGirl.create(:attendance)
    visit new_attendance_path
    page.should have_content("LIMS")
    page.should have_css('#sidebar')
    page.should have_content('Category')
    page.should have_content("New Attendance")
  end
  it "visits a display page" do
    @sample_object = FactoryGirl.create(:attendance)
    visit url_for(@sample_object)
    page.should have_content("LIMS")
    page.should have_css('#sidebar')
    page.should have_content(@sample_object.category)
  end
end