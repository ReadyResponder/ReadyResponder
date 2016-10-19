require 'rails_helper'

RSpec.describe "a user" do
  describe "without a role" do
    before (:each) do
      @person = create(:person)
      sign_in_as(nil) # no role
    end

    it "cannot view people" do
      visit people_path
      expect(page).to have_content("Access Denied")
      expect(page).not_to have_content('Edit') #Need to scope this, or it will fail on Edith
      expect(page).not_to have_content('New')
      expect(page).not_to have_content(@person.lastname)

      visit person_path(@person)
      expect(page).to have_content("Access Denied")
      expect(page).not_to have_content('Edit')
      expect(page).not_to have_content(@person.lastname)

      visit edit_person_path(@person)
      expect(page).to have_content("Access Denied")
    end
  end
end
