require 'rails_helper'

RSpec.describe "Person" do
  before(:each) { sign_in_as('Editor') }

  describe "views" do
    before(:each) do
      Department.destroy_all
      aux = create(:department, name: "Police", shortname: "BAUX")
      cert = create(:department, name: "CERT", shortname: "CERT")
      @dpw = create(:department, shortname: "DPW", manage_people: false)

      cj = create(:person, firstname: 'CJ',  department: aux)
      cj.channels << create(:phone, channel_type: 'Phone', content: '+19785551212', category: "Mobile Phone")
      sierra = create(:person, firstname: 'Sierra', department: cert)
      sierra.channels << create(:email, channel_type: 'Email', category: 'E-Mail', content: 'sierra@example.com')
      create(:person, firstname: 'Adam', status: 'Applicant' )
      create(:person, firstname: 'Priscilla', status: 'Prospect' )
      create(:person, firstname: 'Indy', status: 'Inactive' )
      create(:person, firstname: 'Leona', status: 'Leave of Absence' )
      create(:person, firstname: 'Donna', status: 'Declined' )
      create(:person, firstname: 'Oscar', status: 'Active',  department: @dpw)
      @people_manage_depts = Department.where(manage_people: true)
      @all_depts = Department.all
    end

    it "returns page for All Active people", js: true do
      visit people_path
      # Active checked by default
      expect(page).to have_content('People') # This is in the nav bar
      expect(page).to have_content('All Active')
      expect(page).to have_content('Active:')
      expect(page).to have_content('On-leave:')
      expect(page).to have_checked_field('Active')
      expect(page).to have_unchecked_field('On-leave')
      within(".data-table-departments") do
        expect(page).to have_content('Departments:')
        @people_manage_depts.each do |dept|
          expect(page).to have_content(dept.shortname)
        end
      end
      expect(page).not_to have_content(@dpw.shortname)
      expect(page).to have_content('Home') # This is in the nav bar
      expect(page).to have_content('CJ')
      expect(page).to have_content('Sierra') # Should only show active people from depts managed by people
      expect(page).not_to have_content('Adam')
      expect(page).not_to have_content('Priscilla')
      expect(page).not_to have_content('Indy')
      expect(page).not_to have_content('Leona')
      expect(page).not_to have_content('Oscar')
      page.has_css?('add-btn')

      check "js-people-onLeave-checkbox"
      expect(page).to have_content('Leona')
    end

    it "returns a page for Applicants", js: true do
      visit applicants_people_path
      expect(page).to have_content('People') # This is in the nav bar
      expect(page).to have_content('Applicants')
      expect(page).to have_content('Applicants:')
      expect(page).to have_content('Prospects:')
      expect(page).not_to have_selector(".data-table-departments")
      expect(page).to have_content('Home') # This is in the nav bar
      expect(page).to have_content('Adam') # Should only show applicants by default
      expect(page).not_to have_content('Sierra')
      expect(page).not_to have_content('Priscilla')
      expect(page).not_to have_content('Indy')
      expect(page).not_to have_content('Leona')
      expect(page).not_to have_content('Oscar')
      page.has_css?('add-btn')

      check "js-people-prospect-checkbox"
      expect(page).to have_content('Priscilla')
    end

    it "returns a page for Inactive", js: true do
      visit inactive_people_path
      expect(page).to have_content('People') # This is in the nav bar
      expect(page).to have_content('Inactive People')
      within(".data-table-departments") do
        expect(page).to have_content('Departments:')
        @all_depts.each do |dept|
          expect(page).to have_content(dept.shortname)
        end
      end
      expect(page).to have_content('Home') # This is in the nav bar
      expect(page).to have_content('Indy') # Should only show inactive by default
      expect(page).not_to have_content('Adam')
      expect(page).not_to have_content('Sierra')
      expect(page).not_to have_content('Priscilla')
      expect(page).not_to have_content('Leona')
      expect(page).not_to have_content('Oscar')
      page.has_no_css?('add-btn')
    end

    it "returns a page for Everybody", js: true do
      visit everybody_people_path
      expect(page).to have_content('People') # This is in the nav bar
      expect(page).to have_content('Everybody')
      within(".data-table-departments") do
        expect(page).to have_content('Departments:')
        @all_depts.each do |dept|
          expect(page).to have_content(dept.shortname)
        end
      end
      expect(page).to have_content('Home') # This is in the nav bar
      expect(page).to have_content('Indy') # Should show all people
      expect(page).to have_content('Adam')
      expect(page).to have_content('Sierra')
      expect(page).to have_content('Priscilla')
      expect(page).to have_content('Leona')
      expect(page).to have_content('Oscar')
      page.has_no_css?('add-btn')
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
      person = create(:person, icsid: "509")
      @timecard = create(:timecard, person: person)
      @certification = create(:cert, person: person)
      visit person_path(person)
      expect(page).to have_content(person.fullname)
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

  describe "'Return to Listing' button" do
    it "redirects to previous category" do
      cert = create(:department, name: "CERT", shortname: "CERT")
      person = create(:person, department: cert)
      visit people_path

      click_link(person.name)

      click_on('Return to Listing')

      expect(current_path).to eq(people_path)
    end

    it "redirects properly after edit" do
      cert = create(:department, name: "CERT", shortname: "CERT")
      person = create(:person, department: cert)
      visit people_path

      click_link(person.name)

      click_on('Edit Person')

      fill_in 'First Name', with: "Jane"
      fill_in 'Last Name', with: "Doe"

      click_on('Update Person')

      click_on('Return to Listing')

      expect(current_path).to eq(people_path)
      expect(page).to have_content("Jane Doe")
    end
  end
end
