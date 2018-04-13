require 'rails_helper'

RSpec.describe "Events" do
  before(:each) do
    sign_in_as('Editor')
    @department = create(:department)
  end

  describe "event" do
    it "chooses template" do
      @template = create(:event, is_template: true,
                         title: "The Template", status: "In-session", departments: [@department])
      visit new_event_path
      fill_in "Title", with: "A Standard Event"
      select 'Meeting', :from => 'event_category'
      select 'Scheduled', :from => 'event_status'
      select 'The Template', :from => 'event_template_id'
      fill_in "Description", with: "Really Long Text..."
      fill_in "Start Time", with: "2013-10-31 18:30"
      fill_in "End Time", with: "2013-10-31 23:55"
      fill_in "event_id_code", with: "The_Code"
      select 'Recruit', :from => 'event_min_title'
      check @department.name
      click_on 'Create'
      expect(page).to have_content "Event was successfully created."
      expect(page).to have_content "the_code" # Should be lower case
    end

    it "gets tasks and requirements from template" do
      @template = create(:event, is_template: true,
                         title: "The Template", status: "In-session", departments: [@department])
      @task1 = create(:task, event: @template, title: "Staff Medical Intake")
      @task2 = create(:task, event: @template, title: "Parking")
      @title = create(:title, name: "EMT")
      @task1_req1 = create(:requirement, task: @task1, title: @title)
      visit new_event_path
      fill_in "Title", with: "A Standard Event"
      select 'Meeting', :from => 'event_category'
      select 'Scheduled', :from => 'event_status'
      select 'The Template', :from => 'event_template_id'
      fill_in "Description", with: "Really Long Text..."
      fill_in "Start Time", with: "2013-10-31 18:30"
      fill_in "End Time", with: "2013-10-31 23:55"
      fill_in "event_id_code", with: "The_Code"
      select 'Recruit', :from => 'event_min_title'
      check @department.name
      click_on 'Create'
      expect(page).to have_content "Event was successfully created."
      expect(page).to have_content @task1.title
      expect(page).to have_content @task2.title
      click_on @task1.title # The duplicate will have the same title
      expect(page).to have_content @task1_req1.title
      expect(page).to have_content "Oct 31"
    end

  end
end
