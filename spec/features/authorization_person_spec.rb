require 'spec_helper'
      #save_and_open_page
describe "a user" do
  describe "without a role" do
    before (:each) do
      @person = FactoryGirl.create(:person, lastname: 'YesDoe')
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
      page.should_not have_content('Edit') #Need to scope this, or it will fail on Edith
      page.should_not have_content(@person.lastname)
      visit edit_person_path(@person)
      page.should have_content("Access Denied")
    end
  end
  describe "in the reader role" do
    before (:each) do
      @person = FactoryGirl.create(:person, lastname: 'YesDoe')
      somebody = FactoryGirl.create(:user)
      somebody.roles << FactoryGirl.create(:role, name: 'Reader')
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    it "cannot edit people" do
      visit edit_person_path(@person)
      page.should have_content("Access Denied")
    end
    it "cannot create a new person" do
      visit people_path
      page.should_not have_content('Create')
      visit new_person_path
      page.should have_content("Access Denied")
    end
    it "can read a person" do
      visit people_path
      click_on @person.lastname
      page.should have_content(@person.lastname)
    end
    it "gets a signin sheet when requested" do
      person1 = FactoryGirl.create(:person, lastname: 'YesDoe')
      person2 = FactoryGirl.create(:person, lastname: 'NoDoe', status: 'Inactive')
      visit signin_people_path
      page.should have_content("Command Staff") #This is in the first heading
      page.should have_content("YesDoe")
      page.should_not have_content("NoDoe")
    end
end
  describe "in the editor role" do
    before (:each) do
      @person = FactoryGirl.create(:person, lastname: 'YesDoe')
      somebody = FactoryGirl.create(:user)
      somebody.roles << FactoryGirl.create(:role, name: 'Editor')
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    it "can edit people" do
      visit people_path
      page.should have_content('Edit') #Need to scope this, or it will fail on Edith
      page.should have_content('New')
      
      visit person_path(@person)
      page.should have_content('Edit') #Need to scope this, or it will fail on Edith
      click_on 'Edit'
      current_path.should == edit_person_path(@person)
      page.should_not have_content("Access Denied")
    end
    it "can create a new person" do
      visit people_path
      page.should have_content('New')
      visit new_person_path
      current_path.should == new_person_path
      page.should_not have_content("Access Denied")
    end
    it "can read a person" do
      visit people_path
      click_on @person.lastname
      page.should have_content(@person.lastname)
    end
    it "a signin sheet when requested" do
      person1 = FactoryGirl.create(:person, lastname: 'YesDoe')
      person2 = FactoryGirl.create(:person, lastname: 'NoDoe', status: 'Inactive')
      visit signin_people_path
      page.should have_content("Command Staff") #This is in the first heading
      page.should have_content("YesDoe")
      page.should_not have_content("NoDoe")
    end
  end
end
