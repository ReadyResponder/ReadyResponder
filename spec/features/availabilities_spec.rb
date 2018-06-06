require 'rails_helper'

RSpec.describe "Availabilities" do
  before(:each) { sign_in_as('Editor') }

  # get_basic_editor_views('availability',['person', 'description', 'status'])

  describe "creates" do
    it "availabilities" do
      @person = create(:person, firstname: "Jane", lastname: "Doe")
      visit new_person_availability_path(@person)
      select 'Jane Doe', from: 'availability_person_id'
      select('Unavailable', from: 'availability_status')
      fill_in "Description", with: "Vacation"
      fill_in "availability_start_time", with: "2013-10-31 18:30"
      fill_in "availability_end_time", with: "2013-10-31 23:55"
      click_on 'Create'
      expect(page).to have_content "Availability was successfully created."
    end
  end
end
