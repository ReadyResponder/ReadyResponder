require 'rails_helper'

RSpec.describe Timecard do
  before(:all) do
    @cj = create(:person, firstname: 'CJ')
  end

  describe 'self.overlapping_time' do
    it 'returns all timecards that overlap a date range (start..end)' do
      past_timecard = create(:timecard, person: @cj, start_time: 2.days.ago, end_time: 1.day.ago)
      future_timecard = create(:timecard, person: @cj, start_time: 2.days.from_now, end_time: 3.days.from_now)
      in_between_event_timecard = create(:timecard, person: @cj, start_time: Time.current, end_time: 60.minutes.from_now)
      overlapping_timecard = create(:timecard, person: @cj, start_time: 2.days.ago, end_time: 3.days.from_now)
      event = create(:event)
      event_timecards = Timecard.overlapping_time(event.start_time..event.end_time)
      expect(event_timecards).to include(in_between_event_timecard)
      expect(event_timecards).to include(overlapping_timecard)
      expect(event_timecards).not_to include(past_timecard)
      expect(event_timecards).not_to include(future_timecard)
    end
  end

  describe '.active' do
    it 'returns all timecards that are not cancelled' do
      incomplete_timecard = create(:timecard, person: @cj, status: 'Incomplete')
      unverified_timecard = create(:timecard, person: @cj, status: 'Unverified')
      error_timecard = create(:timecard, person: @cj, status: 'Error')
      verified_timecard = create(:timecard, person: @cj, status: 'Verified')
      cancelled_timecard = create(:timecard, person: @cj, status: 'Cancelled')
      active_timecards = Timecard.active
      expect(active_timecards).to include(incomplete_timecard)
      expect(active_timecards).to include(unverified_timecard)
      expect(active_timecards).to include(error_timecard)
      expect(active_timecards).to include(verified_timecard)
      expect(active_timecards).not_to include(cancelled_timecard)
    end
  end

  describe "creation" do
    it "has a valid factory" do
      timecard = build(:timecard, person: @cj)
      expect(timecard).to be_valid
    end

    it "requires a person" do
      timecard = build(:timecard, person: nil)
      expect(timecard).not_to be_valid
    end

    it "requires end_time to be after start_time" do # chronology
      timecard = build(:timecard, person: @cj, start_time: Time.current, end_time: 2.minutes.ago)
      expect(timecard).not_to be_valid
    end

    it "calculates an duration" do
      @timecard = create(:timecard,  person: @cj, start_time: Time.current, end_time: Time.current)
      expect(@timecard.duration).to eq(0)
      @timecard = create(:timecard,  person: @cj, start_time: Time.current, end_time: 75.minutes.from_now)
      expect(@timecard.duration).to eq(1.25)
    end

    it "finds the existing timecard if it's a duplicate",
      skip: "Find duplicate timecards is too simple, but not needed until people are scanning in" do
      @person = create(:person)
      @original_timecard = create(:timecard,  person: @person,
                                              intended_start_time: 42.minutes.from_now,
                                              intended_end_time: 8.hours.from_now,
                                              intention: "Available")
      @duplicate_timecard = build(:timecard,  person: @person,
                                              intended_start_time: 42.minutes.from_now,
                                              intended_end_time: 8.hours.from_now,
                                              intention: "Available")
      expect(@duplicate_timecard.find_duplicate_timecards.size).to eq(1)
      @duplicate_timecard = build(:timecard, event: @event, person: @person, actual_start_time: 42.minutes.from_now, outcome: "Worked")
      expect(@duplicate_timecard.find_duplicate_timecards.size).to eq(1)
    end
  end
end
