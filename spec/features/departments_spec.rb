require 'rails_helper'

RSpec.feature "Department" do
  describe "user in the editor role" do
    before do
      somebody = create(:user)
      r = create(:role, name: 'Editor')
      somebody.roles << r
      visit new_user_session_path
      fill_in 'user_email', with: somebody.email
      fill_in 'user_password', with: somebody.password
      click_on 'Sign in'
      @department = create(:department, name: "Technology", status: "Active")
    end

    scenario "Creates Department" do
      visit root_path
      click_link "Department"
      click_link "New Department"
      fill_in "Name", with: "Police"
      fill_in "Shortname", with: "P"
      fill_in "Description", with: "Police department"
      select "Active", from: "Status"
      click_button "Create Department"
      expect(page).to have_content "Department successfully created."
      expect(current_path).to eq department_path(Department.last)
    end

    scenario "Updates Department" do
      visit edit_department_path(@department)
      fill_in "Name", with: "Technology"
      fill_in "Shortname", with: "Tech"
      click_button "Update Department"
      expect(page).to have_content "Department successfully updated."
      expect(current_path).to eq department_path(@department)
    end
  end

  describe "user in the reader role" do
    before (:each) do
      @department = create(:department)
      sign_in_as('Reader')
    end

    it "cannot edit department" do
      visit edit_department_path(@department)
      expect(page).to have_content("Access Denied")
    end

    it "cannot create a new department" do
      click_link "Department"
      expect(page).not_to have_content('Create')
      visit new_department_path
      expect(page).to have_content("Access Denied")
    end

    it "can view a department" do
      visit department_path(@department)
      expect(page).to have_content(@department.name)
    end
  end
end
