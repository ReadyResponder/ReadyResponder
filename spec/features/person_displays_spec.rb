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

    it "returns the index page" do
      visit people_path
      expect(page).to have_content('People')
      expect(page).to have_content('LIMS') # This is in the nav bar
      expect(page).to have_content('CJ')
      expect(page).to have_content('555-1212')
      expect(page).to have_content('Sierra')
      expect(page).to have_content('sierra@example.com')
      expect(page).to_not have_content('Adam') # Should not show applicant
      expect(page).to_not have_content('Priscilla')
      expect(page).to_not have_content('Indy')
      expect(page).to_not have_content('Leona')
      expect(page).to_not have_content('Oscar')
    end

    it "returns a page for Police" do
      visit police_people_path
      page.should have_content('Police')
      page.should have_content('LIMS') # This is in the nav bar
      page.should have_content('CJ')
      page.should_not have_content('Sierra')
      page.should_not have_content('Adam')
      page.should_not have_content('Priscilla')
      page.should_not have_content('Indy')
      page.should_not have_content('Leona')
      page.should_not have_content('Oscar')
   end

    it "returns a page for CERT" do
      visit cert_people_path
      page.should have_content('CERT')
      page.should have_content('LIMS') # This is in the nav bar
      page.should_not have_content('CJ')
      page.should have_content('Sierra')
      page.should_not have_content('Adam')
      page.should_not have_content('Priscilla')
      page.should_not have_content('Indy')
      page.should_not have_content('Oscar')
      page.should_not have_content('Leona')
    end

    it "returns a page for Applicants" do
      visit applicants_people_path
      page.should have_content('Applicants')
      page.should have_content('LIMS') # This is in the nav bar
      page.should_not have_content('CJ')
      page.should_not have_content('Sierra')
      page.should have_content('Adam')
      page.should_not have_content('Priscilla')
      page.should_not have_content('Indy')
      page.should_not have_content('Leona')
      page.should_not have_content('Oscar')
    end

    it "returns a page for Prospects" do
      visit prospects_people_path
      page.should have_content('Prospects')
      page.should have_content('LIMS') # This is in the nav bar
      page.should_not have_content('CJ')
      page.should_not have_content('Sierra')
      page.should_not have_content('Adam')
      page.should have_content('Priscilla')
      page.should_not have_content('Indy')
      page.should_not have_content('Leona')
      page.should_not have_content('Oscar')
    end

    it "returns a page for Inactive" do
      visit inactive_people_path
      page.should have_content('Inactive')
      page.should have_content('LIMS') # This is in the nav bar
      page.should_not have_content('CJ')
      page.should_not have_content('Sierra')
      page.should_not have_content('Adam')
      page.should_not have_content('Priscilla')
      page.should have_content('Indy')
      page.should_not have_content('Leona')
      page.should_not have_content('Oscar')
    end
    it "returns a page for Declined" do
      find('#navbar').click_link('Declined')
      page.should have_content('Declined')
      page.should have_content('LIMS') # This is in the nav bar
      page.should_not have_content('CJ')
      page.should_not have_content('Sierra')
      page.should_not have_content('Adam')
      page.should_not have_content('Priscilla')
      page.should_not have_content('Indy')
      page.should_not have_content('Leona')
      page.should have_content('Donna')
      page.should_not have_content('Oscar')
    end
    it "returns a page for on leave" do
      find('#navbar').click_link('Leave')
      page.should have_content('On-Leave')
      page.should have_content('LIMS') # This is in the nav bar
      page.should_not have_content('CJ')
      page.should_not have_content('Sierra')
      page.should_not have_content('Adam')
      page.should_not have_content('Priscilla')
      page.should_not have_content('Indy')
      page.should have_content('Leona')
      page.should_not have_content('Oscar')
    end

    it "returns a page for other" do
      find('#navbar').click_link('Other')
      #visit other_people_path
      page.should have_content('Others')
      page.should have_content('LIMS') # This is in the nav bar
      page.should_not have_content('CJ')
      page.should_not have_content('Sierra')
      page.should_not have_content('Adam')
      page.should_not have_content('Priscilla')
      page.should_not have_content('Indy')
      page.should_not have_content('Leona')
      page.should have_content('Oscar')
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
