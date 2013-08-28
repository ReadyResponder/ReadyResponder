require 'spec_helper'

describe "Events" do
  before (:each)  do
    somebody = FactoryGirl.create(:user)
    r = FactoryGirl.create(:role, name: 'Editor')
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end

  get_basic_editor_views('event',['category', 'description', 'status'])
  describe "creates" do
    it "events" do
      @person1 = FactoryGirl.create(:person)
      @person2 = FactoryGirl.create(:person, firstname: "Jane")
      @person3 = FactoryGirl.create(:person)
      visit new_event_path
      fill_in "Title", with: "Standard Patrol"
      select 'Patrol', :from => 'event_category'
      select('Completed', :from => 'event_status')
      fill_in "Description", with: "Really Long Text..."
      fill_in "Start Time", with: "2013-10-31 18:30"
      fill_in "End Time", with: "2013-10-31 23:55"
      click_on 'Create'
      page.should have_content "Event was successfully created."

      @event = Event.last
      @event.timeslots.count.should eq(0)
      @timeslot_person2 = FactoryGirl.create(:timeslot, event: @event, person: @person2, intention: "Available")
      @event.timeslots.count.should eq(1)
      @event.timeslots.available.count.should eq(1)
      @event.timeslots.available.first.person.should eq(@person2)
      @event.unknown_people.count.should eq(2)
      visit event_path(@event)  #Need to reload it after the changes to the timeslots
      current_path.should == event_path(@event)
      within("#event_timeslots") do
        within("#unknown") do
          page.should have_content(@person1.fullname)
          page.should_not have_content(@person2.fullname)
          page.should have_content(@person3.fullname)
        end
        within("#available") do
          page.should have_content(@person2.fullname)
          #check(@person2.fullname)
        end
        within("#unavailable") do

        end
        within("#scheduled") do

        end
        within("#actually_worked") do

        end
      end
      #1.should eq(2)
    end
  end
  describe "displays" do
    it "a listing" do
      @event = FactoryGirl.create(:event, start_time: nil, end_time: nil, title: "Something divine")
      visit events_path
      within_table("events") do
        page.should have_content("Events")
      	within("tbody") do
      	  page.should have_content(@event.description)
      	end
      end
    end

    it 'an edit form' do
      @event = FactoryGirl.create(:event, start_time: nil, end_time: nil, title: "Something divine")
      visit edit_event_path(@event)
      within("#sidebar") do
        page.should have_content("Cancel")
        #save_and_open_page
      end
    end

    it "an event page" do
      @event = FactoryGirl.create(:event, start_time: nil, end_time: nil)
      visit event_path(@event)
      within('#sidebar') do
        page.should have_content "Return to"
      end
      page.should have_content(@event.title)
      current_path.should == event_path(@event)
    end
  end
end
