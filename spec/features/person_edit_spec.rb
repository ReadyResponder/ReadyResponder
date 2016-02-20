require 'spec_helper'
      #save_and_open_page
describe "Person" do
  before (:each)  do
    somebody = create(:user)
    r = create(:role, name: 'Editor')
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end

  describe "views" do
    before (:each) do
      cj = create(:person, firstname: 'CJ',  department: 'Police' )
      cj.channels << create(:channel, channel_type: 'Phone', content: '9785551212', category: "Mobile Phone")
      sierra = create(:person, firstname: 'Sierra', department: 'CERT' )
      sierra.channels << create(:channel, channel_type: 'Email', category: 'E-Mail', content: 'sierra@example.com')
      create(:person, firstname: 'Adam', status: 'Applicant' )
      create(:person, firstname: 'Priscilla', status: 'Prospect' )
      create(:person, firstname: 'Indy', status: 'Inactive' )
      create(:person, firstname: 'Leona', status: 'Leave of Absence' )
      create(:person, firstname: 'Donna', status: 'Declined' )
      create(:person, firstname: 'Oscar', status: 'Active', department: 'Other' )
    end

  end

  describe "forms should display" do
    it "a new person form with appropriate fields" do
      visit new_person_path
      fill_in('First Name', :with => 'John')
      fill_in('Last Name', :with => 'Jacobie')
      expect(page).to have_select("Gender")
      expect(find_field('person_state').value).to eq 'MA'
      click_button "Create Person"
      expect(page).not_to have_content("Error")
    end

    it "an edit form with values filled in" do
      person = create(:person, icsid: "509")
      visit edit_person_path(person)
      expect(page).to have_field("First Name", :with => "CJ")
      expect(page).to have_select("person_gender", :selected => "Female")
      click_button "Update Person"
      expect(page).not_to have_content("Error")
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
      #save_and_open_page
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
