require 'rails_helper'

RSpec.feature 'Event creation and edition', js: true do
  context 'logged in as an Editor' do
    before(:each) do
      sign_in_as('Editor')
    end

    scenario 'I can click on the "+" link to access a form where I can create a new event' do
      visit events_path
      page.execute_script "window.scrollBy(0,1500)"

      within 'table caption' do
        click_link '+'
      end

      fill_in 'Title', with: 'Some event'
      select 'Meeting', from: 'event_category'
      select 'Completed', from: 'event_status'
      fill_in 'Description', with: 'Really Long Text...'
      fill_in 'Start Time', with: 2.hours.from_now.strftime('%Y-%m-%d %rH:%M')
      fill_in 'End Time', with: 4.hours.from_now.strftime('%Y-%m-%d %rH:%M')
      # This moves the cursor out from the Time selector, clearing the popup
      # so selenium can then click on create
      fill_in 'Id code', with: 'event03'
      click_on 'Create'

      expect(page).to have_content 'Event was successfully created'
      expect(page).to have_content 'Some event'
      expect(page).to have_content 'Code: event03'
    end

    scenario 'I can select an event to edit and then change one or more of its attributes' do
      event = create(:event, status: 'In-session', start_time: 1.hour.from_now, end_time: 3.hours.from_now)

      visit events_path
      page.execute_script "window.scrollBy(0,1500)"
      within 'table#events tbody tr' do
        click_link 'Edit'
      end

      within 'form' do
        expect(page).to have_field('Title', with: event.title)
        expect(page).to have_select('Status', selected: event.status)
      end

      fill_in 'Title', with: 'A new smashing title!'
      page.execute_script "window.scrollBy(0,1500)"
      click_on 'Update'

      expect(page).to have_content 'Event was successfully updated'
      expect(page).to have_content 'A new smashing title!'
    end
  end
end
