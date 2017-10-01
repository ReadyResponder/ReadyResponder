require 'rails_helper'

RSpec.describe "Events" do
  before(:each) { sign_in_as('Editor') }

  get_basic_editor_views('event',['Training', 'Status'])

  describe "search" do
    it "finds current event", js: true do
      @event_one = create(:event, title: "find me")
      @event_two = create(:event, title: "another event")
      @event_three = create(:event, title: "different event")
      visit events_path
      fill_in "Search", with: "find me"
      within_table("events") do
      	within("tbody") do
      	  expect(page).to have_content(@event_one.title)
          expect(page).not_to have_content(@event_two.title)
          expect(page).not_to have_content(@event_three.title)
      	end
      end
    end

    it "finds template event", js: true do
      @event_one = create(:event, title: "find me", is_template: true)
      @event_two = create(:event, title: "another event", is_template: true)
      @event_three = create(:event, title: "different event", is_template: true)
      visit events_templates_path
      fill_in "Search", with: "find me"
      within_table("templates") do
      	within("tbody") do
      	  expect(page).to have_content(@event_one.title)
          expect(page).not_to have_content(@event_two.title)
          expect(page).not_to have_content(@event_three.title)
      	end
      end
    end

    it "finds archive event", js: true do
      @event_one = create(:event, title: "find me", status: "Completed")
      @event_two = create(:event, title: "another event", status: "Completed")
      @event_three = create(:event, title: "different event", status: "Completed")
      visit events_archives_path
      fill_in "Search", with: "find me"
      within_table("archives") do
      	within("tbody") do
      	  expect(page).to have_content(@event_one.title)
          expect(page).not_to have_content(@event_two.title)
          expect(page).not_to have_content(@event_three.title)
      	end
      end
    end

    it "finds no results", js: true do
      @event_one = create(:event, title: "find me", is_template: true)
      @event_two = create(:event, title: "another event", is_template: true)
      @event_three = create(:event, title: "different event", is_template: true)
      visit events_templates_path
      fill_in "Search", with: "this will not find anything"
      within_table("templates") do
      	within("tbody") do
      	  expect(page).not_to have_content(@event_one.title)
          expect(page).not_to have_content(@event_two.title)
          expect(page).not_to have_content(@event_three.title)
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
      @current_scheduled = create(:event, title: "Current scheduled Title", status: "Scheduled")
      @template = create(:event, title: "Current template Title", is_template: true)
      @recent = create(:event, title: "Recent Title", start_time: DateTime.now - 5.hours, end_time: DateTime.now - 1.hours, status: "Cancelled")
      @not_recent = create(:event, title: "Not Recent Title", start_time: DateTime.now - 14.months, end_time: DateTime.now - 1.hours, status: "Cancelled")
      visit events_path
      # current checkbox should be clicked by default
      expect(page).to have_content(@current_insession.title)
      expect(page).to have_content(@current_scheduled.title)
      expect(page).not_to have_content(@recent.title)
      expect(page).not_to have_content(@not_recent.title)
      expect(page).not_to have_content(@template.title)
      page.has_css?("table tr.current-highlight")
      page.has_css?("table tr.recent-highlight")

      uncheck "js-events-current-checkbox"
      check "js-events-recent-checkbox"
      expect(page).to have_content(@current_insession.title)
      expect(page).to have_content(@current_scheduled.title)
      expect(page).to have_content(@recent.title)
      expect(page).not_to have_content(@not_recent.title)
      expect(page).not_to have_content(@template.title)
      page.has_css?("table tr.recent-highlight")
      page.has_css?("table tr.current-highlight")

      check "js-events-current-checkbox"
      check "js-events-recent-checkbox"
      expect(page).to have_content(@current_insession.title)
      expect(page).to have_content(@current_scheduled.title)
      expect(page).to have_content(@recent.title)
      expect(page).not_to have_content(@not_recent.title)
      expect(page).not_to have_content(@template.title)

      uncheck "js-events-current-checkbox"
      uncheck "js-events-recent-checkbox"
      expect(page).not_to have_content(@current_insession.title)
      expect(page).not_to have_content(@current_scheduled.title)
      expect(page).not_to have_content(@recent.title)
      expect(page).not_to have_content(@not_recent.title)
      expect(page).not_to have_content(@template.title)
      expect(page).to have_content("No matching records found")
    end

    it "a template", js: true do
      @template = create(:event, title: "Template Title 2", status: "In-Session", is_template: true)
      visit events_templates_path
      within_table("templates") do
      	within("tbody") do
      	  expect(page).to have_content(@template.title)
          expect(page).not_to have_content(@template.is_template.to_s.capitalize)
          expect(page).to have_content("In-Session")
      	end
      end
    end

    it "a archive", js: true do
      @archive = create(:event, title: "Archive Title 2", status: "Completed")
      visit events_archives_path
      within_table("archives") do
      	within("tbody") do
      	  expect(page).to have_content(@archive.title)
          expect(page).to have_content("Completed")
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
