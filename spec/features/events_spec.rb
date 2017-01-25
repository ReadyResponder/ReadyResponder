require 'rails_helper'

RSpec.describe "Events" do
  before(:each) { sign_in_as('Editor') }

  get_basic_editor_views('event',['Training', 'Status'])
  describe "creates" do
    it "events" do
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

      @event = Event.last
      expect(@event.timecards.count).to eq(0)
      # @timecard_person2 = create(:timecard, event: @event, person: @person2, intention: "Available")
      # @timecard_person3 = create(:timecard, event: @event, person: @person3, intention: "Unavailable")
      # @timecard_person4 = create(:timecard, event: @event, person: @person4, intention: "Scheduled")
      # @timecard_person5 = create(:timecard, event: @event, person: @person5, intention: "Scheduled", outcome: "Worked", actual_start_time: "2013-10-31 18:30" )
      # expect(@event.timecards.count).to eq(4)
      # expect(@event.available_people.count).to eq(1)
      # expect(@event.available_people.first.person).to eq(@person2)
      # expect(@event.timecards.unavailable.count).to eq(1)
      # expect(@event.timecards.unavailable.first.person).to eq(@person3)
      # expect(@event.timecards.scheduled.count).to eq(1)
      # expect(@event.timecards.scheduled.first.person).to eq(@person4)
      # expect(@event.unknown_people.count).to eq(1)
      # visit event_path(@event)  #Need to reload it after the changes to the timecards
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
      #   #check(@person2.fullname)
      #   end
      #   within("#unavailable") do
      #     expect(page).to have_content(@person3.fullname)
      #     expect(page).not_to have_content(@person1.fullname)
      #     expect(page).not_to have_content(@person2.fullname)
      #
      #     #save_and_open_page
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

    it 'an edit form' do
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
    it "hides the course if category isn't training" , js: true,
        :skip => 'Errors in Javascript library' do
      visit new_event_path
      select 'Patrol', :from => 'event_category'
      fill_in "Description", with: "Really Long Text..."  #This ensures the blur event happens
      expect(page).not_to have_content("Course")
      select 'Training', :from => 'event_category'
      fill_in "Description", with: "Really Long Text..."  #This ensures the blur event happens
      expect(page).to have_content("Course")
    end
    it "always fails" do
     #1.should eq(2)
    end
  end
end
