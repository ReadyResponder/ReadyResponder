require 'spec_helper'
      #save_and_open_page
describe "Person" do
  before (:each)  do
    somebody = FactoryGirl.create(:user)
    r = FactoryGirl.create(:role, name: 'Editor')
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end

  describe "GET /people" do
    it "returns a page" do
      visit people_path
      page.should have_content("Listing People")
      page.should have_content("LIMS") # This is in the nav bar
    end
  end

  describe " should display" do

    it "a new person form with a first name field" do
      visit new_person_path
      page.should have_content("First Name")
      fill_in('First Name', :with => 'John')
    end

    it "qualified only if all skills are present" do
      title = FactoryGirl.create(:title, name: "Police Officer")
      drivingskill = FactoryGirl.create(:skill, name: "Driving")
      firstaidskill = FactoryGirl.create(:skill, name: "FRFA")
      title.skills << drivingskill
      title.skills << firstaidskill
      
      frfacourse = FactoryGirl.create(:course, name: "FRFA")
      firstaidskill.courses << frfacourse
      drivingcourse = FactoryGirl.create(:course, name: "Mass DL")
      drivingskill.courses << drivingcourse
      
      person = FactoryGirl.create(:person)
      person.titles << title
      cert = FactoryGirl.create(:cert, person: person, course: frfacourse)
      visit person_path(person)
      page.should have_content("NOT qualified for Police Officer")
      page.should have_content("Driving skill needed")
      cert = FactoryGirl.create(:cert, person: person, course: drivingcourse)
      visit person_path(person)
      page.should have_content("Qualified for Police Officer")
      page.should_not have_content("NOT Qualified")
    end

    it "a person page" do
      person = FactoryGirl.create(:person, icsid: "509")
      visit person_path(person)
      page.should have_content("(509)")
    end

    it "a person without a start date" do
      person = FactoryGirl.create(:person, start_date: nil)
      visit person_path(person)
      page.should have_content("Status")
    end
    
    pending "all certs, even expired" do
      person = FactoryGirl.create(:person)
      course = FactoryGirl.create(:course, name: "Basket Weaving")
      expiredcert = FactoryGirl.create(:cert, person: person, course: course, status: "Expired")
      visit person_path(person)
      save_and_open_page
      page.should have_content("Basket Weaving")
    end
  end
end
