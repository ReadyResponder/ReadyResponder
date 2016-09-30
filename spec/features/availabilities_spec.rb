require 'spec_helper'

describe "Availabilities" do
  before (:each)  do
    somebody = create(:user)
    r = create(:role, name: 'Editor')
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end

  get_nested_editor_views('person', 'availability', ['description', 'status'])

  describe "creates" do
    it "availabilities" do
      @person = create(:person, firstname: "Jane", lastname: "Doe")
      visit new_person_availability_path(@person)
      select 'Jane Doe', :from => 'availability_person_id'
      select('Unavailable', :from => 'availability_status')
      fill_in "Description", with: "Vacation"
      fill_in "availability_start_time", with: "2013-10-31 18:30"
      fill_in "availability_end_time", with: "2013-10-31 23:55"
      click_on 'Create'
      expect(page).to have_content "Availability was successfully created."
    end
  end
end
