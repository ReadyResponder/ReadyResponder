require 'rails_helper'

RSpec.describe Timecard do
  before(:each) do
    @cj = create(:person, firstname: 'CJ')
    @tc = create(:timecard, person: @cj)
  end

  context "Access Control" do
    it "denies anonymous access" do
      visit timecards_path
      expect(page).to have_content("You need to sign in")

      visit new_timecard_path
      expect(page).to have_content("You need to sign in")

      visit url_for(@tc)
      expect(page).to have_content("You need to sign in")
    end
  end

  context "Normal useage" do
    before(:each) do
      sign_in_as('Editor')
    end

    it "gets the index" do
      visit timecards_path
      expect(page).to have_content("Home") # In the nav bar
      expect(page).to have_css('#sidebar')
      expect(page).to have_content("Listing Timecards")
      expect(page).to have_content(@tc.status)
    end

    it "visits a creation form" do
      visit new_timecard_path
      expect(page).to have_content("Home")
      expect(page).to have_css('#sidebar')
      expect(page).to have_content('Status')
      expect(page).to have_content("New Timecard")
    end

    it "visits a display page" do
      visit timecard_path(@tc)
      expect(page).to have_content("Home")
      expect(page).to have_css('#sidebar')
      expect(page).to have_content(@tc.status)
    end

    it "visits a display page without actual times" do
      @tc = create(:timecard, person: @cj, start_time: nil, end_time: nil)

      visit timecard_path(@tc)
      expect(page).to have_content("Home")
      expect(page).to have_css('#sidebar')
      expect(page).to have_content(@tc.status)

      visit timecards_path
      expect(page).to have_content("Home")

      visit person_path(@tc.person)
      expect(page).to have_content("Home")
    end
  end
end
