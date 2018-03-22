require 'rails_helper'

RSpec.feature "User visits and event show page", type: :feature do
  scenario "It shows the availablitites", js: true do
    sign_in_as('Editor')

    event_start_time = 2.hours.from_now
    event_end_time = 12.hours.from_now
    event = create(:event, start_time: event_start_time, end_time: event_end_time)

    time_before_event = 1.hour.from_now
    time_after_event = 13.hours.from_now
    first_full_availability = create(:availability, start_time: time_before_event, end_time: time_after_event)
    second_full_availability = create(:availability, start_time: time_before_event, end_time: time_after_event)
    
    visit events_path
    click_on event.title
    click_on "Availabilities"

    expect(page).to have_content "Available", count: 2
    expect(page).to have_content first_full_availability.person.name, count: 1
    expect(page).to have_content second_full_availability.person.name, count: 1
  end
end