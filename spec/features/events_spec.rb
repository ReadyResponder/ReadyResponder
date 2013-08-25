require 'spec_helper'

describe "Events" do
  before (:each)  do
    @timeslot = FactoryGirl.create(:timeslot) #Which also creates an event and a person
    @event = @timeslot.event
    @person = @timeslot.person
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
    it "timeslots" do
      @person2 = FactoryGirl.create(:person)
      @person2.timeslots.count.should eq(0)
      visit edit_event_path(@event)
      check(@person2.fullname)
      click_on 'Update'
      @person2.timeslots.count.should eq(1)
      1.should eq(2)
    end

  end
  describe "displays" do
    it "a listing" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit events_path
      page.should have_content("Listing Events")
      page.should have_css('#sidebar')
      within_table("events") do
      	within("tbody") do
      	  page.should have_content(@event.description)
      	  #pending page.should have_css("td")  # this is only picking up the edit button at the end, not an event show link
      	end
      end
    end
    it 'an edit form' do
      visit edit_event_path(@event)
      within("#sidebar") do
        page.should have_content("Cancel")
        #save_and_open_page
      end
    end
    it "an event page" do
      @timeslot = FactoryGirl.create(:timeslot) #this creates a person as well
      @event = @timeslot.event
      @event.start_time = nil
      @event.end_time = nil
      @event.save!
      visit event_path(@event)
      within('#sidebar') do
        page.should have_content "Return to"
      end
      page.should have_content(@event.description)
    end

  end
end
