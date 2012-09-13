require 'spec_helper'
#Don't use capybara (ie visit/have_content and       #response.status.should be(200)

describe "Person" do
  describe "GET /people" do
    it "returns a page" do
      visit people_path
      page.should have_content("Listing People")
    end
  end

  describe " should display" do
    it "a signin sheet when requested" do
      visit signin_people_path
      page.should have_content("Sign-in")
    end
    it "a new person form with a first name field" do
      visit new_person_path
      page.should have_content("First Name")
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

    it " a person page" do
      person = FactoryGirl.create(:person, icsid: "509")
      visit person_path(person)
      page.should have_content("(509)")
    end

    it "a person without a start date" do
      person = FactoryGirl.create(:person, start_date: nil)
      visit person_path(person)
      page.should have_content("Status")
    end
    
    it "all certs, even expired" do
      person = FactoryGirl.create(:person)
      course = FactoryGirl.create(:course, name: "Basket Weaving")
      expiredcert = FactoryGirl.create(:cert, person: person, course: course, status: "Expired")
      visit person_path(person)
      page.should have_content("Basket Weaving")
    end
  end

end
