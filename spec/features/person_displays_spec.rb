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
      FactoryGirl.create(:person, firstname: 'CJ',  department: 'Police' )
      FactoryGirl.create(:person, firstname: 'Klaus', department: 'CERT' )
      FactoryGirl.create(:person, firstname: 'Adam', status: 'Applicant' )
      FactoryGirl.create(:person, firstname: 'Priscilla', status: 'Prospect' )
      FactoryGirl.create(:person, firstname: 'Indy', status: 'Inactive' )
      FactoryGirl.create(:person, firstname: 'Leona', status: 'Leave of Absence' )
      FactoryGirl.create(:person, firstname: 'Donna', status: 'Declined' )
    end

    it "returns the index page" do
      visit people_path
      page.should have_content('Listing People')
      page.should have_content('LIMS') # This is in the nav bar
      page.should have_content('CJ')
      page.should_not have_content('Adam')
      page.should_not have_content('Priscilla')
      page.should_not have_content('Indy')
      page.should_not have_content('Leona')
    end

    it "returns a page for Police" do
      visit police_people_path
      page.should have_content('Listing Police')
      page.should have_content('LIMS') # This is in the nav bar
      page.should have_content('CJ')
      page.should_not have_content('Klaus')
      page.should_not have_content('Adam')
      page.should_not have_content('Priscilla')
      page.should_not have_content('Indy')
       page.should_not have_content('Leona')
   end

    it "returns a page for CERT" do
      visit cert_people_path
      page.should have_content('Listing CERT')
      page.should have_content('LIMS') # This is in the nav bar
      page.should_not have_content('CJ')
      page.should have_content('Klaus')
      page.should_not have_content('Adam')
      page.should_not have_content('Priscilla')
      page.should_not have_content('Indy')
      page.should_not have_content('Leona')
    end

    it "returns a page for Applicants" do
      visit applicants_people_path
      page.should have_content('Listing Applicants')
      page.should have_content('LIMS') # This is in the nav bar
      page.should_not have_content('CJ')
      page.should_not have_content('Klaus')
      page.should have_content('Adam')
      page.should_not have_content('Priscilla')
      page.should_not have_content('Indy')
      page.should_not have_content('Leona')
    end

    it "returns a page for Prospects" do
      visit prospects_people_path
      page.should have_content('Listing Prospects')
      page.should have_content('LIMS') # This is in the nav bar
      page.should_not have_content('CJ')
      page.should_not have_content('Klaus')
      page.should_not have_content('Adam')
      page.should have_content('Priscilla')
      page.should_not have_content('Indy')
      page.should_not have_content('Leona')
    end
    it "returns a page for Inactive" do
      visit inactive_people_path
      page.should have_content('Listing Inactive')
      page.should have_content('LIMS') # This is in the nav bar
      page.should_not have_content('CJ')
      page.should_not have_content('Klaus')
      page.should_not have_content('Adam')
      page.should_not have_content('Priscilla')
      page.should have_content('Indy')
      page.should_not have_content('Leona')
    end
    it "returns a page for Declined" do
      visit declined_people_path
      page.should have_content('Listing Declined')
      page.should have_content('LIMS') # This is in the nav bar
      page.should_not have_content('CJ')
      page.should_not have_content('Klaus')
      page.should_not have_content('Adam')
      page.should_not have_content('Priscilla')
      page.should_not have_content('Indy')
      page.should_not have_content('Leona')
      page.should have_content('Donna')
    end
    it "returns a page for on leave" do
      visit leave_people_path
      page.should have_content('Listing On-Leave')
      page.should have_content('LIMS') # This is in the nav bar
      page.should_not have_content('CJ')
      page.should_not have_content('Klaus')
      page.should_not have_content('Adam')
      page.should_not have_content('Priscilla')
      page.should_not have_content('Indy')
      page.should have_content('Leona')
    end

  end

  describe "forms should display" do
    it "a new person form with appropriate fields" do
      visit new_person_path
      page.should have_content("First Name")
      fill_in('First Name', :with => 'John')
      page.should have_select("Gender")
      find_field('person_state').value.should have_content('MA')
    end

    it "an edit form with values filled in" do
      person = FactoryGirl.create(:person, icsid: "509")
      visit edit_person_path(person)
      page.should have_field("First Name", :with => "CJ")
      page.should have_select("person_gender", :selected => "Female")  
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
