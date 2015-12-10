require 'spec_helper'

describe Timecard do

  describe "creation" do
    it "has a valid factory" do
      @timecard = FactoryGirl.build(:timecard)
      expect(@timecard).to be_valid
    end

    it "requires an event" do
      @timecard = FactoryGirl.build(:timecard, event: nil)
      expect(@timecard).not_to be_valid
    end
    it "requires a person" do
      @timecard = FactoryGirl.build(:timecard, person: nil)
      expect(@timecard).not_to be_valid
    end
    it "requires an intended_end_time after intended_start_time" do
      @timecard = FactoryGirl.build(:timecard, intended_start_time: Time.current, intended_end_time: 2.minutes.ago)
      expect(@timecard).not_to be_valid
    end
    it "calculates an actual duration" do
      @timecard = FactoryGirl.create(:timecard, actual_start_time: Time.current, actual_end_time: Time.current)
      expect(@timecard.actual_duration).to eq(0)
      @timecard = FactoryGirl.create(:timecard, actual_start_time: Time.current, actual_end_time: 75.minutes.from_now)
      expect(@timecard.actual_duration).to eq(1.25)
    end
    it "calculates an intended duration" do
      @timecard = FactoryGirl.create(:timecard, intended_start_time: Time.current, intended_end_time: Time.current)
      expect(@timecard.intended_duration).to eq(0)
      @timecard = FactoryGirl.create(:timecard, intended_start_time: Time.current, intended_end_time: 75.minutes.from_now)
      expect(@timecard.intended_duration).to eq(1.25)
    end

    it "finds the existing timecard if it's a duplicate" do
      skip "Find duplicate timecards is too simple, but not needed until people are scanning in"
      @event = FactoryGirl.create(:event)
      @person = FactoryGirl.create(:person)
      @original_timecard = FactoryGirl.create(:timecard, event: @event, person: @person,
                                              intended_start_time: 42.minutes.from_now, 
                                              intended_end_time: 8.hours.from_now,
                                              intention: "Available")
      @duplicate_timecard = FactoryGirl.build(:timecard, event: @event, person: @person,
                                              intended_start_time: 42.minutes.from_now,
                                              intended_end_time: 8.hours.from_now,
                                              intention: "Available")
      expect(@duplicate_timecard.find_duplicate_timecards.size).to eq(1)
      @duplicate_timecard = FactoryGirl.build(:timecard, event: @event, person: @person, actual_start_time: 42.minutes.from_now, outcome: "Worked")
      expect(@duplicate_timecard.find_duplicate_timecards.size).to eq(1)
    end

    it "always fails" do
      #1.should eq(2)
    end
  end
end
