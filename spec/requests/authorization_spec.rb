require 'spec_helper'
      #save_and_open_page
describe "a user" do
  describe "in the reader role" do
    before (:each) do
      person = FactoryGirl.create(:person)
      somebody = FactoryGirl.create(:user)
      r = FactoryGirl.create(:role, name: 'Reader')
      somebody.roles << r
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    it "cannot edit people" do
      visit people_path
      page.should_not have_content('Edit') #Need to scope this, or it will fail on Edith
      person = FactoryGirl.create(:person, lastname: 'YesDoe')
      visit edit_person_path(person)
      page.should have_content("Access Denied")
    end
    it "cannot create a new person" do
      visit people_path
      page.should_not have_content('Create')
      visit new_person_path
      page.should have_content("Access Denied")
    end
    it "can read a person" do
      person = FactoryGirl.create(:person)
      visit people_path
      #save_and_open_page
      click_on person.lastname
      page.should have_content(person.lastname)
    end
    pending "a signin sheet when requested" do
      person1 = FactoryGirl.create(:person, lastname: 'YesDoe')
      person2 = FactoryGirl.create(:person, lastname: 'NoDoe', status: 'Inactive')
      visit signin_people_path
      #save_and_open_page
      page.should have_content("Command Staff") #This is in the first heading
      page.should have_content("YesDoe")
      page.should_not have_content("NoDoe")
    end
end
=begin
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
  end
=end
end
