require 'rails_helper'

RSpec.describe "Notifications" do
  describe " visit notifications" do
    before (:each) { sign_in_as('Editor') }

    context "from an event" do
      let!(:event)  { create(:event) }
      it "should create a notification for that event" do
        allow_any_instance_of(Notification).to receive(:activate!).and_return(nil)
        allow_any_instance_of(Notification).to receive(:event).and_return(Event.new)
        visit event_path(event)
        expect(page).to have_content('Description:')
        within("#sidebar") do
          expect(page).to have_content('New Notification')
        end
        click_on 'New Notification'
        fill_in 'Subject', with: "Please respond"
        select 'Active', :from => 'Status'
        click_on 'Create Notification'
        within("#flash_notice") do
          expect(page).to have_content "Notification was successfully created."
        end
      end
    end  end
end
