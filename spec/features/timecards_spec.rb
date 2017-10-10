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

  context "Normal usage" do
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

    context "verify timecard" do

      it "verify button exists on all applicable pages" do
        @tc = create(:timecard, person: @cj, status: 'Unverified')

        visit timecards_path
        expect(page).to have_button('Verify')

        visit person_path(@cj)
        expect(page).to have_button('Verify')

        visit timecard_path(@tc)
        expect(page).to have_button('Verify')
      end

      it "click 'Verify' button for timecard from timecards page" do
        @tc1 = create(:timecard, person: @cj, status: 'Unverified')

        visit timecards_path
        click_button "Verify"

        expect(page).not_to have_button('Verify')
        expect(page).not_to have_content('Unverified')
      end

      it "click 'Verify' button for persons timecard from timecard page @tc2" do
        @tc2 = create(:timecard, person: @cj, status: 'Unverified')

        visit timecard_path(@tc2)
        click_button "Verify"

        expect(page).not_to have_button('Verify')
        expect(page).not_to have_content('Unverified')
      end

      it "click 'Verify' button for CJ's timecard from CJ's show page" do
        @tc3 = create(:timecard, person: @cj, status: 'Unverified')

        visit person_path(@cj)
        click_button "Verify"

        expect(page).not_to have_button('Verify')
        expect(page).not_to have_content('Unverified')
      end

      it 'views timecards from event show', js: true do
        @event = create(:event, start_time: 1.day.ago, end_time: 1.day.from_now)
        @event_timecard = create(:timecard, start_time: Time.current, end_time: 60.minutes.from_now)
        visit event_path(@event)

        click_link 'Timecards'
        expect(page).not_to have_content(@tc.person.name)
        expect(page).to have_content(@event_timecard.person.name)
      end
    end

    context "unable to verify timecard" do

      it "tries to verify timecard in a status other than 'Unverified'" do
        @incomplete = create(:timecard, person: @cj, status: 'Incomplete')
        @error = create(:timecard, person: @cj, status: 'Error')
        @verified = create(:timecard, person: @cj, status: 'Verified')

        visit person_path(@cj)

        expect(page).not_to have_button('Verify')
      end
    end
  end

  context "Manager Usage" do
    before(:each) do
      sign_in_as('Manager')
    end

    context "verify timecard" do

      it "verify button exists on all applicable pages" do
        @tc = create(:timecard, person: @cj, status: 'Unverified')

        visit timecards_path
        expect(page).to have_button('Verify')

        visit person_path(@cj)
        expect(page).to have_button('Verify')

        visit timecard_path(@tc)
        expect(page).to have_button('Verify')
      end

      it "click 'Verify' button for timecard from timecards page" do
        @tc1 = create(:timecard, person: @cj, status: 'Unverified')

        visit timecards_path
        click_button "Verify"

        expect(page).not_to have_button('Verify')
        expect(page).not_to have_content('Unverified')
      end

      it "click 'Verify' button for persons timecard from timecard page @tc2" do
        @tc2 = create(:timecard, person: @cj, status: 'Unverified')

        visit timecard_path(@tc2)
        click_button "Verify"

        expect(page).not_to have_button('Verify')
        expect(page).not_to have_content('Unverified')
      end

      it "click 'Verify' button for CJ's timecard from CJ's show page" do
        @tc3 = create(:timecard, person: @cj, status: 'Unverified')

        visit person_path(@cj)
        click_button "Verify"

        expect(page).not_to have_button('Verify')
        expect(page).not_to have_content('Unverified')
      end
    end

    context "unable to verify timecard" do

      it "tries to verify timecard in a status other than 'Unverified'" do
        @incomplete = create(:timecard, person: @cj, status: 'Incomplete')
        @error = create(:timecard, person: @cj, status: 'Error')
        @verified = create(:timecard, person: @cj, status: 'Verified')

        visit person_path(@cj)

        expect(page).not_to have_button('Verify')
      end
    end
  end
end
