require 'spec_helper'

describe Timeslot do

  describe "creation" do
    it "has a valid factory" do
      @timeslot = FactoryGirl.build(:timeslot)
      @timeslot.should be_valid
    end
    
    it "requires an event" do
      @timeslot = FactoryGirl.build(:timeslot, event: nil)
      @timeslot.should_not be_valid
    end
    it "requires a person" do
      @timeslot = FactoryGirl.build(:timeslot, person: nil)
      @timeslot.should_not be_valid
    end
    it "requires an intended_end_time after intended_start_time" do
      @timeslot = FactoryGirl.build(:timeslot, intended_start_time: Time.current, intended_end_time: 2.minutes.ago)
      @timeslot.should_not be_valid
    end
    it "calculates an actual duration" do
      @timeslot = FactoryGirl.create(:timeslot, actual_start_time: Time.current, actual_end_time: Time.current)
      @timeslot.actual_duration.should eq(0)
      @timeslot = FactoryGirl.create(:timeslot, actual_start_time: Time.current, actual_end_time: 75.minutes.from_now)
      @timeslot.actual_duration.should eq(1.25)
    end
    it "calculates an intended duration" do
      @timeslot = FactoryGirl.create(:timeslot, intended_start_time: Time.current, intended_end_time: Time.current)
      @timeslot.intended_duration.should eq(0)
      @timeslot = FactoryGirl.create(:timeslot, intended_start_time: Time.current, intended_end_time: 75.minutes.from_now)
      @timeslot.intended_duration.should eq(1.25)
      #1.should eq(2)
    end
  end
end
