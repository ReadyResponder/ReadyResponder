require 'rails_helper'

RSpec.feature 'Events filtering', js: true do
  context 'logged in as an Editor' do
    before(:each) do
      sign_in_as('Editor')
    end

    scenario 'given a set of events, I can search for one of them by its title' do
      event = create(:event, title: 'The event')
      other_events = create_list(:event, 2)
      event_name = event.title

      visit events_path
      fill_in 'Search', with: event_name

      within 'table#events tbody' do
        expect(page).to have_content(event_name)
        expect(page).not_to have_content(other_events.first.title)
        expect(page).not_to have_content(other_events.second.title)
      end
    end

    scenario 'given a set of templates, I can search for one of them by its title' do
      template = create(:event, is_template: true, title: 'The template event')
      other_templates = create_list(:event, 2, is_template: true)
      template_name = template.title

      visit events_templates_path
      fill_in 'Search', with: template_name

      within 'table#templates tbody' do
        expect(page).to have_content(template_name)
        expect(page).not_to have_content(other_templates.first.title)
        expect(page).not_to have_content(other_templates.second.title)
      end
    end

    scenario 'given a set of archived events, I can search for one of them by its title' do
      archived_event = create(:event, status: 'Completed', title: 'The template event')
      other_archived_events = create_list(:event, 2, status: 'Completed')
      archived_event_name = archived_event.title

      visit events_archives_path
      fill_in 'Search', with: archived_event_name
      within 'table#archives tbody' do
        expect(page).to have_content(archived_event_name)
        expect(page).not_to have_content(other_archived_events.first.title)
        expect(page).not_to have_content(other_archived_events.second.title)
      end
    end

    scenario 'given a set of events, if I search for a title that does not exists, I get no results' do
      events = create_list(:event, 3)

      visit events_path
      fill_in 'Search', with: 'A non existent title'

      within 'table#events tbody' do
        expect(page).to have_content("No matching records found")
        expect(page).not_to have_content(events.first.title)
        expect(page).not_to have_content(events.second.title)
        expect(page).not_to have_content(events.third.title)
      end
    end

    context 'given a set of past, recent and current events' do
      before(:each) do
        @past_event     = create(:event, start_time: 14.months.ago, end_time: 1.hour.ago, status: 'Completed')
        @recent_event   = create(:event, start_time: 6.months.ago, end_time: 1.hour.ago, status: 'Completed')
        @current_event  = create(:event, status: 'In-session')
        @template_event = create(:event, is_template: true)
      end

      scenario 'I can filter the set by current and/or recent events' do
        visit events_path

        check   'js-events-current-checkbox'
        uncheck 'js-events-recent-checkbox'

        within(".dataTables_scroll") do
          expect(page).to have_content @current_event.title
          expect(page).not_to have_content @recent_event.title
          expect(page).not_to have_content @past_event.title
          expect(page).not_to have_content @template_event.title
        end

        uncheck 'js-events-current-checkbox'
        check   'js-events-recent-checkbox'

        within(".dataTables_scroll") do
          expect(page).to have_content @current_event.title
          expect(page).to have_content @recent_event.title
          expect(page).not_to have_content @past_event.title
          expect(page).not_to have_content @template_event.title
        end

        check 'js-events-current-checkbox'
        check 'js-events-recent-checkbox'

        within(".dataTables_scroll") do
          expect(page).to have_content @current_event.title
          expect(page).to have_content @recent_event.title
          expect(page).not_to have_content @past_event.title
          expect(page).not_to have_content @template_event.title
        end 

        uncheck 'js-events-current-checkbox'
        uncheck 'js-events-recent-checkbox'

        within(".dataTables_scroll") do
          expect(page).to have_content 'No matching records found'
        end
      end
    end
  end
end
