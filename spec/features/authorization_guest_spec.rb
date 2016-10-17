require 'rails_helper'
      #save_and_open_page
RSpec.describe "a user" do
  describe "without a role" do
    before (:each) do
      @person = create(:person)
      somebody = create(:user)
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    it "cannot view people" do
      visit people_path
      expect(page).not_to have_content('Edit') #Need to scope this, or it will fail on Edith
      expect(page).not_to have_content('New')
      expect(page).not_to have_content(@person.lastname)
      expect(page).to have_content("Access Denied")
      
      visit person_path(@person)
      expect(page).not_to have_content('Edit')
      expect(page).not_to have_content(@person.lastname)
      visit edit_person_path(@person)
      expect(page).to have_content("Access Denied")
    end
  end
end
