require 'rails_helper'

RSpec.describe "a user" do
  before(:each) do
    @department = create(:department, name: "Police")
    @person = create(:person, department_id: @department.id)
    
  end

  describe "in the reader role" do
    before (:each) { sign_in_as('Reader') }

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
      @person_active = create(:person, department_id:  @department.id)
      @person_inactive = create(:person, status: 'Inactive', department_id:  @department.id)
      visit signin_people_path
      expect(page).to have_content("Command") #This is in the first heading
      expect(page).to have_content(@person_active.lastname)
      expect(page).not_to have_content(@person_inactive.lastname)
    end
  end

  describe "in the editor role" do
    before (:each) { sign_in_as('Editor') }

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
      expect(page).to have_content('Home')
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
      @person_active = create(:person, department_id:  @department.id)
      @person_inactive = create(:person, status: 'Inactive', department_id:  @department.id)
      visit signin_people_path
      expect(page).to have_content("Command") #This is in the first heading
      expect(page).to have_content(@person_active.lastname)
      expect(page).not_to have_content(@person_inactive.lastname)
    end
  end
end
