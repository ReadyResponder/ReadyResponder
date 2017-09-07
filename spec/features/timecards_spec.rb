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

  context "Manager Usage" do
    before(:each) do
      sign_in_as('Manager')
    end

    it "check if 'Verify' button exists on all applicable pages" do
      @tc = create(:timecard, person: @cj, status: 'Unverified')

      visit timecards_path
      expect(page).to have_button('Verify')

      visit person_path(@cj)
      expect(page).to have_button('Verify')

      visit timecard_path(@tc)
      expect(page).to have_button('Verify')
    end

    it "click 'Verify' button for persons timecard from all applicable pages" do
      @tc1 = create(:timecard, person: @cj, status: 'Unverified')

      visit timecards_path
      click_button "Verify"

      expect(page).not_to have_button('Verified')
      expect(page).not_to have_content('Unverified')

      @tc2 = create(:timecard, person: @cj, status: 'Unverified')

      visit timecard_path(@tc2)
      click_button "Verify"

      expect(page).not_to have_button('Verified')
      expect(page).not_to have_content('Unverified')

      @tc3 = create(:timecard, person: @cj, status: 'Unverified')

      visit person_path(@cj)
      click_button "Verify"

      expect(page).not_to have_button('Verified')
      expect(page).not_to have_content('Unverified')
    end
  end
end
