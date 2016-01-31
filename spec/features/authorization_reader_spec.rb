require 'spec_helper'
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
      visit edit_person_path(@person)
      expect(page).to have_content("Access Denied")
    end
    it "cannot create a new person" do
      visit people_path
      expect(page).not_to have_content('Create')
      visit new_person_path
      expect(page).to have_content("Access Denied")
    end
    it "can view a person" do
      visit people_path
      click_on @person.lastname
      expect(page).to have_content(@person.lastname)
    end
    it "gets a signin sheet when requested" do
      @person_active = create(:person)
      @person_inactive = create(:person, status: 'Inactive')
      visit signin_people_path
      expect(page).to have_content("Command Staff") #This is in the first heading
      expect(page).to have_content(@person_active.lastname)
      expect(page).not_to have_content(@person_inactive.lastname)
    end
  end
end
