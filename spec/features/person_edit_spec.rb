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

  describe "views" do
    before (:each) do
      cj = FactoryGirl.create(:person, firstname: 'CJ',  department: 'Police' )
      cj.channels << FactoryGirl.create(:channel, channel_type: 'Phone', content: '9785551212', category: "Mobile Phone")
      sierra = FactoryGirl.create(:person, firstname: 'Sierra', department: 'CERT' )
      sierra.channels << FactoryGirl.create(:channel, channel_type: 'Email', category: 'E-Mail', content: 'sierra@example.com')
      FactoryGirl.create(:person, firstname: 'Adam', status: 'Applicant' )
      FactoryGirl.create(:person, firstname: 'Priscilla', status: 'Prospect' )
      FactoryGirl.create(:person, firstname: 'Indy', status: 'Inactive' )
      FactoryGirl.create(:person, firstname: 'Leona', status: 'Leave of Absence' )
      FactoryGirl.create(:person, firstname: 'Donna', status: 'Declined' )
      FactoryGirl.create(:person, firstname: 'Oscar', status: 'Active', department: 'Other' )
    end

  end

  describe "forms should display" do
    it "a new person form with appropriate fields" do
      visit new_person_path
      fill_in('First Name', :with => 'John')
      fill_in('Last Name', :with => 'Jacobie')
      page.should have_select("Gender")
      find_field('person_state').value.should have_content('MA')
      click_button "Create Person"
      page.should_not have_content("Error")
    end

    it "an edit form with values filled in" do
      person = FactoryGirl.create(:person, icsid: "509")
      visit edit_person_path(person)
      page.should have_field("First Name", :with => "CJ")
      page.should have_select("person_gender", :selected => "Female")
      click_button "Update Person"
      page.should_not have_content("Error")
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
      #save_and_open_page
      page.should have_content("NOT qualified for Police Officer")
      page.should have_content("Driving") #This test is vague. Need to ensure Driving is in the missing skills section
      cert = FactoryGirl.create(:cert, person: person, course: drivingcourse)
      visit person_path(person)
      page.should have_content("Qualified for Police Officer")
      page.should_not have_content("NOT Qualified")
    end

    it "a person page" do
      @timecard = FactoryGirl.create(:timecard) #this creates a person as well
      @person = @timecard.person
      @certification = FactoryGirl.create(:cert, person: @person)
      visit person_path(@person)
      page.should have_content(@person.fullname)
    end

    it "a person without a start date" do
      person = FactoryGirl.create(:person, start_date: nil)
      visit person_path(person)
      page.should have_content("Status")
    end

    skip "all certs, even expired" do
      person = FactoryGirl.create(:person)
      course = FactoryGirl.create(:course, name: "Basket Weaving")
      expiredcert = FactoryGirl.create(:cert, person: person, course: course, status: "Expired")
      visit person_path(person)
      page.should have_content("Basket Weaving")
    end
  end
end
