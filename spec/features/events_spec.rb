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

RSpec.feature 'Event creation and edition', js: true do
  context 'logged in as an Editor' do
    before(:each) do
      sign_in_as('Editor')
    end

    scenario 'I can click on the "+" link to access a form where I can create a new event' do
      visit events_path
      
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
      within 'table#events tbody tr' do
        click_link 'Edit'
      end

      within 'form' do
        expect(page).to have_field('Title', with: event.title)
        expect(page).to have_select('Status', selected: event.status)
      end

      fill_in 'Title', with: 'A new smashing title!'
      click_on 'Update'

      expect(page).to have_content 'Event was successfully updated'
      expect(page).to have_content 'A new smashing title!'
    end
  end
end

RSpec.describe "Events" do
  before(:each) do
    sign_in_as('Editor')
    @template = create(:event, title: "template title", is_template: true)
    @current = create(:event, title: "current title", status: "In-session")
    @recent = create(:event, title: "recent title")
    @archive = create(:event, title: "archive title", status: "Completed")
  end

  # removed sidebar so disabling this test for now
  # get_basic_editor_views('event',['Training', 'Status'])

  describe "creates" do
    it "events", js: true do
      @person1 = create(:person)
      @person2 = create(:person, firstname: "Jane")
      @person3 = create(:person)
      @person4 = create(:person)
      @person5 = create(:person)
      visit new_event_path
      fill_in "Title", with: "Standard Event"
      select 'Meeting', :from => 'event_category'
      select('Completed', :from => 'event_status')
      fill_in "Description", with: "Really Long Text..."
      fill_in "Start Time", with: "2013-10-31 18:30"
      fill_in "End Time", with: "2013-10-31 23:55"
      fill_in "event_id_code", with: "Code"
      click_on 'Create'
      expect(page).to have_content "Event was successfully created."

      # @event = Event.last
      # expect(@event.timecards.count).to eq(4)
      # expect(@event.available_people.count).to eq(1)
      # expect(@event.available_people.first.person).to eq(@person2)
      # expect(@event.unknown_people.count).to eq(1)
      # visit event_path(@event)  # Need to reload it after the changes to the timecards
      # expect(current_path).to eq(event_path(@event))
      # within("#event_timecards") do
      #   within("#unknown") do
      #     expect(page).to have_content(@person1.fullname)
      #     expect(page).not_to have_content(@person2.fullname)
      #     expect(page).not_to have_content(@person3.fullname)
      #   end
      #   within("#available") do
      #     expect(page).to have_content(@person2.fullname)
      #     expect(page).not_to have_content(@person1.fullname)
      #     expect(page).not_to have_content(@person3.fullname)
      #     check(@person2.fullname)
      #   end
      #   within("#unavailable") do
      #     expect(page).to have_content(@person3.fullname)
      #     expect(page).not_to have_content(@person1.fullname)
      #     expect(page).not_to have_content(@person2.fullname)
      #   end
      #   page.has_css?('#xxscheduled-headings') #Why doesn't this fail ?!?
      #   within("#scheduled") do
      #
      #   end
      #   within("#worked") do
      #
      #   end
      # end
    end
  end
  describe "displays" do
    it "a listing" do
      @event = create(:event, title: "Something divine")
      visit events_path
      within_table("events") do
        expect(page).to have_content("Events")
      	within("tbody") do
      	  expect(page).to have_content(@event.title)
      	end
      end
    end

    it "checkboxes current, recent on index page", js: true do
      @current_insession = create(:event, title: "Current insession Title", status: "In-session")
      @cancelled = create(:event, title: "Cancelled Title", status: "Cancelled")
      @closed = create(:event, title: "Closed Title", status: "Closed")
      @not_recent = create(:event, title: "Not Recent Title", start_time: DateTime.now - 14.months, end_time: DateTime.now - 1.hours, status: "Cancelled")
      visit events_path
      page.execute_script "window.scrollBy(0,1500)"
      within(".dataTables_scroll") do
        # current checkbox should be clicked by default
        expect(page).to have_content(@current_insession.title)
        expect(page).to have_content(@current.title)
        expect(page).to have_content(@recent.title)
        expect(page).not_to have_content(@cancelled.title)
        expect(page).not_to have_content(@closed.title)
        expect(page).not_to have_content(@not_recent.title)
        expect(page).not_to have_content(@template.title)
        page.has_css?("table tr.current-highlight")
        page.has_css?("table tr.recent-highlight")

        uncheck "js-events-current-checkbox"
        check "js-events-recent-checkbox"
        expect(page).to have_content(@current_insession.title)
        expect(page).to have_content(@current.title)
        expect(page).to have_content(@recent.title)
        expect(page).to have_content(@cancelled.title)
        expect(page).to have_content(@closed.title)
        expect(page).not_to have_content(@not_recent.title)
        expect(page).not_to have_content(@template.title)
        page.has_css?("table tr.recent-highlight")
        page.has_css?("table tr.current-highlight")

        check "js-events-current-checkbox"
        check "js-events-recent-checkbox"
        expect(page).to have_content(@current_insession.title)
        expect(page).to have_content(@current.title)
        expect(page).to have_content(@recent.title)
        expect(page).to have_content(@cancelled.title)
        expect(page).to have_content(@closed.title)
        expect(page).not_to have_content(@not_recent.title)
        expect(page).not_to have_content(@template.title)

        uncheck "js-events-current-checkbox"
        uncheck "js-events-recent-checkbox"
        expect(page).not_to have_content(@current_insession.title)
        expect(page).not_to have_content(@current.title)
        expect(page).not_to have_content(@closed.title)
        expect(page).not_to have_content(@cancelled.title)
        expect(page).not_to have_content(@recent.title)
        expect(page).not_to have_content(@not_recent.title)
        expect(page).not_to have_content(@template.title)
        expect(page).to have_content("No matching records found")
      end
    end

    it "a template", js: true do
      visit events_templates_path
      within_table("templates") do
      	within("tbody") do
      	  expect(page).to have_content(@template.title)
          expect(page).not_to have_content(@current.title)
          expect(page).not_to have_content(@template.is_template.to_s.capitalize)
          expect(page).to have_content("Scheduled")
      	end
      end
    end

    it "archives", js: true do
      @scheduled = create(:event, title: "scheduled", status: "Scheduled")
      @in_session = create(:event, title: "in session", status: "In-session")
      @closed = create(:event, title: "closed", status: "Closed")
      @cancelled = create(:event, title: "cancelled", status: "Cancelled")
      @completed = create(:event, title: "completed", status: "Completed")
      @not_recent = create(:event, title: "Not Recent Title", start_time: DateTime.now - 14.months, end_time: DateTime.now - 1.hours)
      visit events_archives_path
      within_table("archives") do
      	within("tbody") do
      	  expect(page).to have_content(@archive.title)
          expect(page).to have_content(@current.title)
          expect(page).to have_content(@recent.title)
          expect(page).to have_content(@scheduled.title)
          expect(page).to have_content(@in_session.title)
          expect(page).to have_content(@not_recent.title)
          expect(page).to have_content(@closed.title)
          expect(page).to have_content(@cancelled.title)
          expect(page).to have_content(@completed.title)
          expect(page).not_to have_content(@template.title)
      	end
      end
    end

    it "an event page" do
      @event = create(:event, :meeting)
      visit event_path(@event)
      within('#sidebar') do
        expect(page).to have_content "Return to"
      end
      expect(page).to have_content(@event.title)
      expect(current_path).to eq(event_path(@event))
    end

    it "the new course if category is training", js: true do
      visit new_event_path
      select 'Patrol', :from => 'event_category'
      fill_in "Description", with: "Really Long Text..."  #This ensures the blur event happens
      expect(page).not_to have_content("Course")
      select 'Training', :from => 'event_category'
      fill_in "Description", with: "Really Long Text..."  #This ensures the blur event happens
      expect(page).to have_content("Course")
    end

    it "the new course if category is not training", js: true do
      visit new_event_path
      select 'Patrol', :from => 'event_category'
      fill_in "Description", with: "Really Long Text..."  #This ensures the blur event happens
      expect(page).not_to have_content("Course")
      select 'Meeting', :from => 'event_category'
      fill_in "Description", with: "Really Long Text..."  #This ensures the blur event happens
      expect(page).to_not have_content("Course")
    end

    it "the edit course if original category is training", js: true do
      @event = create(:event, :training)
      visit edit_event_path(@event)
      expect(page).to have_content("Course")
      select "Meeting", :from => 'event_category'
      expect(page).to_not have_content("Course")
    end

    it "the edit course if original category is not training", js: true do
      @event = create(:event, :meeting)
      visit edit_event_path(@event)
      expect(page).to_not have_content("Course")
      select "Training", :from => 'event_category'
      expect(page).to have_content("Course")
    end

  end
end
