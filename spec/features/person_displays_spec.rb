require 'rails_helper'

RSpec.describe "Person" do
  before(:each) { sign_in_as('Editor') }

  describe "views" do
    before (:each) do
      department_1 = create(:department, name: "Police")
      department_2 = create(:department, name: "CERT")
      department_3 = create(:department, name: "Other")
      
      cj = create(:person, firstname: 'CJ',  department_id: department_1.id)
      cj.channels << create(:phone, channel_type: 'Phone', content: '9785551212', category: "Mobile Phone")
      sierra = create(:person, firstname: 'Sierra', department_id: department_2.id)
      sierra.channels << create(:email, channel_type: 'Email', category: 'E-Mail', content: 'sierra@example.com')
      create(:person, firstname: 'Adam', status: 'Applicant' )
      create(:person, firstname: 'Priscilla', status: 'Prospect' )
      create(:person, firstname: 'Indy', status: 'Inactive' )
      create(:person, firstname: 'Leona', status: 'Leave of Absence' )
      create(:person, firstname: 'Donna', status: 'Declined' )
      create(:person, firstname: 'Oscar', status: 'Active',  department_id: department_3.id)
    end

    it "returns the index page" do
      visit people_path
      expect(page).to have_content('People')
      expect(page).to have_content('Home') # This is in the nav bar
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
      expect(page).to have_content('Police')
      expect(page).to have_content('Home') # This is in the nav bar
      expect(page).to have_content('CJ')
      expect(page).not_to have_content('Sierra')
      expect(page).not_to have_content('Adam')
      expect(page).not_to have_content('Priscilla')
      expect(page).not_to have_content('Indy')
      expect(page).not_to have_content('Leona')
      expect(page).not_to have_content('Oscar')
   end

    it "returns a page for CERT" do
      visit cert_people_path
      expect(page).to have_content('CERT')
      expect(page).to have_content('Home') # This is in the nav bar
      expect(page).not_to have_content('CJ')
      expect(page).to have_content('Sierra')
      expect(page).not_to have_content('Adam')
      expect(page).not_to have_content('Priscilla')
      expect(page).not_to have_content('Indy')
      expect(page).not_to have_content('Oscar')
      expect(page).not_to have_content('Leona')
    end

    it "returns a page for Applicants" do
      visit applicants_people_path
      expect(page).to have_content('Applicants')
      expect(page).to have_content('Home') # This is in the nav bar
      expect(page).not_to have_content('CJ')
      expect(page).not_to have_content('Sierra')
      expect(page).to have_content('Adam')
      expect(page).not_to have_content('Priscilla')
      expect(page).not_to have_content('Indy')
      expect(page).not_to have_content('Leona')
      expect(page).not_to have_content('Oscar')
    end

    it "returns a page for Prospects" do
      visit prospects_people_path
      expect(page).to have_content('Prospects')
      expect(page).to have_content('Home') # This is in the nav bar
      expect(page).not_to have_content('CJ')
      expect(page).not_to have_content('Sierra')
      expect(page).not_to have_content('Adam')
      expect(page).to have_content('Priscilla')
      expect(page).not_to have_content('Indy')
      expect(page).not_to have_content('Leona')
      expect(page).not_to have_content('Oscar')
    end

    it "returns a page for Inactive" do
      visit inactive_people_path
      expect(page).to have_content('Inactive')
      expect(page).to have_content('Home') # This is in the nav bar
      expect(page).not_to have_content('CJ')
      expect(page).not_to have_content('Sierra')
      expect(page).not_to have_content('Adam')
      expect(page).not_to have_content('Priscilla')
      expect(page).to have_content('Indy')
      expect(page).not_to have_content('Leona')
      expect(page).not_to have_content('Oscar')
    end
    it "returns a page for Declined" do
      find('#navbar').click_link('Declined')
      expect(page).to have_content('Declined')
      expect(page).to have_content('Home') # This is in the nav bar
      expect(page).not_to have_content('CJ')
      expect(page).not_to have_content('Sierra')
      expect(page).not_to have_content('Adam')
      expect(page).not_to have_content('Priscilla')
      expect(page).not_to have_content('Indy')
      expect(page).not_to have_content('Leona')
      expect(page).to have_content('Donna')
      expect(page).not_to have_content('Oscar')
    end
    it "returns a page for on leave" do
      find('#navbar').click_link('Leave')
      expect(page).to have_content('On-Leave')
      expect(page).to have_content('Home') # This is in the nav bar
      expect(page).not_to have_content('CJ')
      expect(page).not_to have_content('Sierra')
      expect(page).not_to have_content('Adam')
      expect(page).not_to have_content('Priscilla')
      expect(page).not_to have_content('Indy')
      expect(page).to have_content('Leona')
      expect(page).not_to have_content('Oscar')
    end

    it "returns a page for other" do
      find('#navbar').click_link('Other')
      #visit other_people_path
      expect(page).to have_content('Others')
      expect(page).to have_content('Home') # This is in the nav bar
      expect(page).not_to have_content('CJ')
      expect(page).not_to have_content('Sierra')
      expect(page).not_to have_content('Adam')
      expect(page).not_to have_content('Priscilla')
      expect(page).not_to have_content('Indy')
      expect(page).not_to have_content('Leona')
      expect(page).to have_content('Oscar')
    end

  end

  describe "forms should display" do
    it "a new person form with appropriate fields" do
      visit new_person_path
      expect(page).to have_content("First Name")
      fill_in('First Name', :with => 'John')
      expect(page).to have_select("Gender")
      expect(find_field('person_state').value).to have_content('MA')
    end

    it "an edit form with values filled in" do
      person = create(:person, icsid: "509")
      visit edit_person_path(person)
      expect(page).to have_field("First Name", :with => "CJ")
      expect(page).to have_select("person_gender", :selected => "Female")
    end

    it "qualified only if all skills are present" do
      title = create(:title, name: "Police Officer")
      drivingskill = create(:skill, name: "Driving")
      firstaidskill = create(:skill, name: "FRFA")
      title.skills << drivingskill
      title.skills << firstaidskill

      frfacourse = create(:course, name: "FRFA")
      firstaidskill.courses << frfacourse
      drivingcourse = create(:course, name: "Mass DL")
      drivingskill.courses << drivingcourse

      person = create(:person)
      person.titles << title
      cert = create(:cert, person: person, course: frfacourse)

      visit person_path(person)
      expect(page).to have_content("NOT qualified for Police Officer")
      expect(page).to have_content("Driving") #This test is vague. Need to ensure Driving is in the missing skills section

      cert = create(:cert, person: person, course: drivingcourse)
      visit person_path(person)
      expect(page).to have_content("Qualified for Police Officer")
      expect(page).not_to have_content("NOT Qualified")
    end

    it "a person page" do
      @timecard = create(:timecard) #this creates a person as well
      @person = @timecard.person
      @certification = create(:cert, person: @person)
      visit person_path(@person)
      expect(page).to have_content(@person.fullname)
    end

    it "a person without a start date" do
      person = create(:person, start_date: nil)
      visit person_path(person)
      expect(page).to have_content("Status")
    end

    skip "all certs, even expired" do
      person = create(:person)
      course = create(:course, name: "Basket Weaving")
      expiredcert = create(:cert, person: person, course: course, status: "Expired")
      visit person_path(person)
      expect(page).to have_content("Basket Weaving")
    end
  end
end
