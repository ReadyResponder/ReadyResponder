require 'rails_helper'

RSpec.describe Timecard do
  before(:all) do
    @cj = create(:person, firstname: 'CJ')
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
