require 'spec_helper'
      #save_and_open_page
describe "a user" do
  describe "without a role" do
    before (:each) do
      @person = FactoryGirl.create(:person)
      somebody = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    it "cannot view people" do
      visit people_path
      page.should_not have_content('Edit') #Need to scope this, or it will fail on Edith
      page.should_not have_content('New')
      page.should_not have_content(@person.lastname)
      page.should have_content("Access Denied")
      
      visit person_path(@person)
      page.should_not have_content('Edit')
      page.should_not have_content(@person.lastname)
      visit edit_person_path(@person)
      page.should have_content("Access Denied")
    end
  end
end
