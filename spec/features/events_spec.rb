require 'rails_helper'

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

  describe "search" do
    it "finds current event", js: true do
      @event_two = create(:event, title: "another event")
      @event_three = create(:event, title: "different event")
      visit events_path
      fill_in "Search", with: "current title"
      within_table("events") do
      	within("tbody") do
      	  expect(page).to have_content(@current.title)
          expect(page).not_to have_content(@event_two.title)
          expect(page).not_to have_content(@event_three.title)
      	end
      end
    end

    it "finds template event", js: true do
      @event_two = create(:event, title: "another event", is_template: true)
      @event_three = create(:event, title: "different event", is_template: true)
      visit events_templates_path
      fill_in "Search", with: "template title"
      within_table("templates") do
      	within("tbody") do
      	  expect(page).to have_content(@template.title)
          expect(page).not_to have_content(@event_two.title)
          expect(page).not_to have_content(@event_three.title)
      	end
      end
    end

    it "finds archive event", js: true do
      @event_two = create(:event, title: "another event")
      @event_three = create(:event, title: "different event")
      visit events_archives_path
      fill_in "Search", with: "archive title"
      within_table("archives") do
      	within("tbody") do
      	  expect(page).to have_content(@archive.title)
          expect(page).not_to have_content(@event_two.title)
          expect(page).not_to have_content(@event_three.title)
      	end
      end
    end

    it "finds no results", js: true do
      visit events_archives_path
      fill_in "Search", with: "this will not find anything"
      within_table("archives") do
      	within("tbody") do
      	  expect(page).not_to have_content(@template.title)
          expect(page).not_to have_content(@current.title)
          expect(page).not_to have_content(@recent.title)
          expect(page).not_to have_content(@archive.title)
          expect(page).to have_content("No matching records found")
      	end
      end
    end
  end

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

    it "checkboxes current, past, templates on index page", js: true do
      @current_insession = create(:event, title: "Current insession Title", status: "In-session")
      @cancelled = create(:event, title: "Cancelled Title", status: "Cancelled")
      @closed = create(:event, title: "Closed Title", status: "Closed")
      @not_recent = create(:event, title: "Not Recent Title", start_time: DateTime.now - 14.months, end_time: DateTime.now - 1.hours, status: "Cancelled")
      visit events_path
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

    it "all events", js: true do
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

    it "an edit form" do
      @event = create(:event, title: "Something divine")
      visit edit_event_path(@event)
      within("#sidebar") do
        expect(page).to have_content("Cancel")
      end
    end

    it "an event page" do
      @event = create(:event)
      visit event_path(@event)
      within('#sidebar') do
        expect(page).to have_content "Return to"
      end
      expect(page).to have_content(@event.title)
      expect(current_path).to eq(event_path(@event))
    end
    
    it "the course if category is training", js: true do
      visit new_event_path
      select 'Patrol', :from => 'event_category'
      fill_in "Description", with: "Really Long Text..."  #This ensures the blur event happens
      expect(page).not_to have_content("Course")
      select 'Training', :from => 'event_category'
      fill_in "Description", with: "Really Long Text..."  #This ensures the blur event happens
      expect(page).to have_content("Course")
    end
  end
end
