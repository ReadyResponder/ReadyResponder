require 'spec_helper'
      #save_and_open_page
describe "a user" do
  describe "without a role" do
    before (:each) do
      somebody = create(:user)
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    it "cannot view skills" do
      skill = create(:skill)
      visit people_path
      expect(page).not_to have_content('Edit') #Need to scope this, or it will fail on Edith
      expect(page).not_to have_content(skill.name)
      expect(page).to have_content("Access Denied")
      
      visit skill_path(skill)
      expect(page).not_to have_content('Edit') #Need to scope this, or it will fail on Edith
      expect(page).not_to have_content(skill.name)
      visit edit_skill_path(skill)
      expect(page).to have_content("Access Denied")
    end
  end
  describe "in the reader role" do
    before (:each) do
      somebody = create(:user)
      r = create(:role, name: 'Reader')
      somebody.roles << r
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    it "cannot edit skills" do
      skill = create(:skill)
      visit edit_skill_path(skill)
      expect(page).to have_content("Access Denied")
    end
    it "cannot create a new skill" do
      visit skills_path
      expect(page).not_to have_content('Create')
      visit new_skill_path
      expect(page).to have_content("Access Denied")
    end
    it "can read a skill" do
      skill = create(:skill)
      visit skills_path
      click_on skill.name
      expect(page).to have_content(skill.name)
    end
  end
  describe "in the editor role" do
    before (:each) do
      @person = create(:person)
      somebody = create(:user)
      r = create(:role, name: 'Editor')
      somebody.roles << r
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    it "can edit people" do
      visit people_path
      within_table("people") do
        expect(page).to have_content("Active")
        expect(page).to have_content('Edit') #Need to scope this, or it will fail on Edith
      end
      visit person_path(@person)
      expect(page).to have_content('Edit') #Need to scope this, or it will fail on Edith
      click_on 'Edit'
      expect(current_path).to eq(edit_person_path(@person))
      expect(page).not_to have_content("Access Denied")
    end
    it "can create a new person" do
      visit new_person_path
      expect(current_path).to eq(new_person_path)
      expect(page).not_to have_content("Access Denied")
    end
    it "can read a person" do
      visit people_path
      click_on @person.lastname
      expect(page).to have_content(@person.lastname)
    end
  end
end
