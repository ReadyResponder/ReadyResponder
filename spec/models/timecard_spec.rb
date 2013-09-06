require 'spec_helper'

describe Timecard do

  describe "creation" do
    it "has a valid factory" do
      @timecard = FactoryGirl.build(:timecard)
      @timecard.should be_valid
    end
    
    it "requires an event" do
      @timecard = FactoryGirl.build(:timecard, event: nil)
      @timecard.should_not be_valid
    end
    it "requires a person" do
      @timecard = FactoryGirl.build(:timecard, person: nil)
      @timecard.should_not be_valid
    end
    it "requires an intended_end_time after intended_start_time" do
      @timecard = FactoryGirl.build(:timecard, intended_start_time: Time.current, intended_end_time: 2.minutes.ago)
      @timecard.should_not be_valid
    end
    it "calculates an actual duration" do
      @timecard = FactoryGirl.create(:timecard, actual_start_time: Time.current, actual_end_time: Time.current)
      @timecard.actual_duration.should eq(0)
      @timecard = FactoryGirl.create(:timecard, actual_start_time: Time.current, actual_end_time: 75.minutes.from_now)
      @timecard.actual_duration.should eq(1.25)
    end
    it "calculates an intended duration" do
      @timecard = FactoryGirl.create(:timecard, intended_start_time: Time.current, intended_end_time: Time.current)
      @timecard.intended_duration.should eq(0)
      @timecard = FactoryGirl.create(:timecard, intended_start_time: Time.current, intended_end_time: 75.minutes.from_now)
      @timecard.intended_duration.should eq(1.25)
    end

    it "finds the existing timecard if it's a duplicate" do
      @event = FactoryGirl.create(:event)
      @person = FactoryGirl.create(:person)
      @original_timecard = FactoryGirl.create(:timecard, event: @event, person: @person, intended_start_time: Time.current, intention: "Available")
      @duplicate_timecard = FactoryGirl.build(:timecard, event: @event, person: @person, intended_start_time: Time.current, intention: "Available")
      @duplicate_timecard.find_duplicate_timecards.count.should eq(1)
      @duplicate_timecard = FactoryGirl.build(:timecard, event: @event, person: @person, actual_start_time: Time.current, outcome: "Worked")
      @duplicate_timecard.find_duplicate_timecards.count.should eq(1)
    end

    it "always fails" do
      #1.should eq(2)
    end
  end
end
