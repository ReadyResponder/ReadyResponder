require 'spec_helper'
      #save_and_open_page
describe "a user" do
  describe "in the reader role" do
    before (:each) do
      @person = FactoryGirl.create(:person)
      somebody = FactoryGirl.create(:user)
      somebody.roles << FactoryGirl.create(:role, name: 'Reader')
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
    it "can read a person" do
      visit people_path
      click_on @person.lastname
      expect(page).to have_content(@person.lastname)
    end
    it "gets a signin sheet when requested" do
      @person_active = FactoryGirl.create(:person)
      @person_inactive = FactoryGirl.create(:person, status: 'Inactive')
      visit signin_people_path
      expect(page).to have_content("Command Staff") #This is in the first heading
      expect(page).to have_content(@person_active.lastname)
      expect(page).not_to have_content(@person_inactive.lastname)
    end
  end
  describe "in the editor role" do
    before (:each) do
      @person = FactoryGirl.create(:person)
      somebody = FactoryGirl.create(:user)
      somebody.roles << FactoryGirl.create(:role, name: 'Editor')
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    it "can edit people" do
      visit people_path
      expect(page).to have_content('Edit') #Need to scope this, or it will fail on Edith
      visit person_path(@person)
      expect(page).to have_content('Edit') #Need to scope this, or it will fail on Edith
      click_on 'Edit'
      expect(current_path).to eq(edit_person_path(@person))
      expect(page).not_to have_content("Access Denied")
    end
    it "can create a new person" do
      visit people_path
      expect(page).to have_content('LIMS')
      visit new_person_path
      expect(current_path).to eq(new_person_path)
      expect(page).not_to have_content("Access Denied")
    end
    it "can read a person" do
      visit people_path
      click_on @person.lastname
      expect(page).to have_content(@person.lastname)
    end
    it "a signin sheet when requested" do
      @person_active = FactoryGirl.create(:person)
      @person_inactive = FactoryGirl.create(:person, status: 'Inactive')
      visit signin_people_path
      expect(page).to have_content("Command Staff") #This is in the first heading
      expect(page).to have_content(@person_active.lastname)
      expect(page).not_to have_content(@person_inactive.lastname)
    end
  end
end