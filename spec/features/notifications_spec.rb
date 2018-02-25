require 'rails_helper'

RSpec.describe "Notifications" do
  describe " visit notifications" do
    before (:each) { sign_in_as('Editor') }
    let(:department) { create(:department) }
    let!(:notification)  { create(:notification,
                                  subject: "Howdy from Hopedale",
                                  departments: [department]) }
    context "basic CRUD" do
      it "should display a single notification" do
        visit notification_path(notification)
        expect(page).to have_content("Howdy")
      end
    end
    context "create a notification" do
      let!(:valid_department)  { create(:department, manage_people: true, name: 'Valid Dept') }
      let!(:invalid_department)  { create(:department, manage_people: false, name: 'Invalid Dept') }
      let!(:event)  { create(:event, departments: [valid_department]) }
      it "can create a notification without event" do
        allow_any_instance_of(Notification).to receive(:activate!).and_return(nil)
        visit notifications_path

        click_link '+'
        within(".form-inputs") do
          expect(page).not_to have_content('Event')
        end
        fill_in 'Subject', with: "Please respond"
        select 'Active', :from => 'Status'
        check 'Valid Dept'
        click_on 'Create Notification'
        within("#flash_notice") do
          expect(page).to have_content "Notification was successfully created."
        end
        expect(page.current_path).to eq notification_path(Notification.last.id)
      end
      it "can create a notification from that event" do
        allow_any_instance_of(Notification).to receive(:activate!).and_return(nil)
        allow_any_instance_of(Notification).to receive(:event).and_return(event)
        visit event_path(event)
        expect(page).to have_content('Description:')
        within("#sidebar") do
          expect(page).to have_content('New Notification')
        end
        click_on 'New Notification'
        within(".form-inputs") do
          expect(page).to have_content('Event')
        end
        expect(page).to have_content('Valid Dept')
        expect(page).to_not have_content('Invalid Dept')
        fill_in 'Subject', with: "Please respond"
        select 'Active', :from => 'Status'
        check 'Valid Dept'
        click_on 'Create Notification'
        within("#flash_notice") do
          expect(page).to have_content "Notification was successfully created."
        end
        expect(page.current_path).to eq event_path(event)
      end
      it "should display errors if form not filled out correctly" do
        allow_any_instance_of(Notification).to receive(:activate!).and_return(nil)
        allow_any_instance_of(Notification).to receive(:event).and_return(event)
        visit event_path(event)
        click_on 'New Notification'
        fill_in 'Subject', with: "Please respond"
        select 'Active', :from => 'Status'
        click_on 'Create Notification'
        expect(page).to have_content "All recipients can't be blank"
        #verifies form fields are still valid after errors
        fill_in 'Subject', with: "Please respond"
        select 'Active', :from => 'Status'
        check 'Valid Dept'
      end
    end
  end
end
