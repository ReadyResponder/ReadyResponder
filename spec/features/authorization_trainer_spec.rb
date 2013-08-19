require 'spec_helper'
      #save_and_open_page
describe "a user in the trainer role" do
  before (:each) do
    @person = FactoryGirl.create(:person)
    somebody = FactoryGirl.create(:user)
    somebody.roles << FactoryGirl.create(:role, name: 'Trainer')
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end
  it "cannot edit people" do
    visit edit_person_path(@person)
    page.should have_content("Access Denied")
  end
  it "cannot create a new person" do
    visit people_path
    page.should_not have_content('Create')
    visit new_person_path
    page.should have_content("Access Denied")
  end
  it "can read a person" do
    visit people_path
    click_on @person.lastname
    page.should have_content(@person.lastname)
  end
  it "get a signin sheet when requested" do
    @person_active = FactoryGirl.create(:person)
    @person_inactive = FactoryGirl.create(:person, status: 'Inactive')
    visit signin_people_path
    page.should have_content("Command Staff") #This is in the first heading
    page.should have_content(@person_active.lastname)
    page.should_not have_content(@person_inactive.lastname)
  end
  it "can add a certification" do
    visit person_path(@person)
    find('#sidebar').should have_link('New Certification')
  end
end