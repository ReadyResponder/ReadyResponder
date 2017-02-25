require 'rails_helper'

RSpec.describe "a user" do
  describe "in the reader role" do
    before (:each) do
      @department = create(:department, shortname: "BAUX")
      @person = create(:person, department: @department)
      sign_in_as('Reader')
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
      @person_active = create(:person, department_id:  @department.id)
      @person_inactive = create(:person, status: 'Inactive', department_id:  @department.id)
      visit signin_people_path
      expect(page).to have_content("Command") # This is in the first heading
      expect(page).to have_content(@person_active.lastname)
      expect(page).not_to have_content(@person_inactive.lastname)
    end
  end
end
