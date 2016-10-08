require 'rails_helper'

      #save_and_open_page
describe "a user" do
  describe "in the reader role" do
    before (:each) do
      @person = create(:person)
      somebody = create(:user)
      somebody.roles << create(:role, name: 'Reader')
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    it "cannot edit people" do
      visit people_path
      expect(page).not_to have_content('Edit') #Need to scope this, or it will fail on Edith
      visit edit_person_path(@person)
      expect(page).to have_content("Access Denied")
    end
    it "cannot create a new person" do
      visit people_path
      expect(page).not_to have_content('Create')
      visit new_person_path
      expect(page).to have_content("Access Denied")
    end
    it "can read a person" do
      visit people_path
      click_on @person.lastname
      expect(page).to have_content(@person.lastname)
    end
end
=begin
    it "a new person form with a first name field" do
      visit new_person_path
      page.should have_content("First Name")
      fill_in('First Name', :with => 'John')
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
      page.should have_content("NOT qualified for Police Officer")
      page.should have_content("Driving skill needed")
      cert = create(:cert, person: person, course: drivingcourse)
      visit person_path(person)
      page.should have_content("Qualified for Police Officer")
      page.should_not have_content("NOT Qualified")
    end
  end
=end
end
