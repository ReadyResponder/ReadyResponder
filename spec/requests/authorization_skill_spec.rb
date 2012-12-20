require 'spec_helper'
      #save_and_open_page
describe "a user" do
  describe "without a role" do
    before (:each) do
      somebody = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    it "cannot view skills" do
      skill = FactoryGirl.create(:skill)
      visit people_path
      page.should_not have_content('Edit') #Need to scope this, or it will fail on Edith
      page.should_not have_content('New')
      page.should_not have_content(skill.name)
      page.should have_content("Access Denied")
      
      visit skill_path(skill)
      page.should_not have_content('Edit') #Need to scope this, or it will fail on Edith
      page.should_not have_content(skill.name)
      visit edit_skill_path(skill)
      page.should have_content("Access Denied")
    end
  end
  describe "in the reader role" do
    before (:each) do
      somebody = FactoryGirl.create(:user)
      r = FactoryGirl.create(:role, name: 'Reader')
      somebody.roles << r
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    it "cannot edit skills" do
      skill = FactoryGirl.create(:skill)
      visit edit_skill_path(skill)
      page.should have_content("Access Denied")
    end
    it "cannot create a new skill" do
      visit skills_path
      page.should_not have_content('Create')
      visit new_skill_path
      page.should have_content("Access Denied")
    end
    it "can read a skill" do
      skill = FactoryGirl.create(:skill)
      visit skills_path
      click_on skill.name
      page.should have_content(skill.name)
    end
  end
  describe "in the editor role" do
    before (:each) do
      person = FactoryGirl.create(:person, lastname: 'YesDoe')
      somebody = FactoryGirl.create(:user)
      r = FactoryGirl.create(:role, name: 'Editor')
      somebody.roles << r
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    it "can edit people" do
      visit people_path
      page.should have_content('Edit') #Need to scope this, or it will fail on Edith
      page.should have_content('New')
      
      person = FactoryGirl.create(:person, lastname: 'YesDoe')
      visit person_path(person)
      page.should have_content('Edit') #Need to scope this, or it will fail on Edith
      click_on 'Edit'
      current_path.should == edit_person_path(person)
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
      person = FactoryGirl.create(:person, lastname: 'YesDoe')
      visit people_path
      click_on person.lastname
      page.should have_content(person.lastname)
    end
  end
end
