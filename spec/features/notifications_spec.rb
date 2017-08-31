require 'rails_helper'

RSpec.describe "Notifications" do
  describe " visit notifications" do
    before (:each) { sign_in_as('Editor') }
    let!(:notification)  { create(:notification, subject: "Howdy from Hopedale") }
    context "basic CRUD" do
      it "should display a single notification" do
        visit notification_path(notification)
        expect(page).to have_content("Howdy")
      end
    end
    context "from an event" do
      let!(:valid_department)  { create(:department, manage_people: true, name: 'Valid Dept') }
      let!(:invalid_department)  { create(:department, manage_people: false, name: 'Invalid Dept') }
      let!(:event)  { create(:event, departments: [valid_department]) }
      it "should create a notification for that event" do
        allow_any_instance_of(Notification).to receive(:activate!).and_return(nil)
        allow_any_instance_of(Notification).to receive(:event).and_return(event)
        visit event_path(event)
        expect(page).to have_content('Description:')
        within("#sidebar") do
          expect(page).to have_content('New Notification')
        end
        click_on 'New Notification'
        expect(page).to have_content('Valid Dept')
        expect(page).to_not have_content('Invalid Dept')
        fill_in 'Subject', with: "Please respond"
        select 'Active', :from => 'Status'
        click_on 'Create Notification'
        within("#flash_notice") do
          expect(page).to have_content "Notification was successfully created."
        end
      end
    end
  end
end
