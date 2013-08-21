require 'spec_helper'

describe Timeslot do

  describe "creation" do
    it "requires an event" do
      @timeslot = FactoryGirl.build(:timeslot, event: nil)
      @timeslot.should_not be_valid
    end
    it "requires a person" do
      @timeslot = FactoryGirl.build(:timeslot, person: nil)
      @timeslot.should_not be_valid
    end
    it "requires an end_time anfter start_time" do
      @timeslot = FactoryGirl.build(:timeslot, start_time: Time.current, end_time: 2.minutes.ago)
      @timeslot.should_not be_valid
    end
    it "calculates a duration" do
      @timeslot = FactoryGirl.create(:timeslot, start_time: Time.current, end_time: Time.current)
      @timeslot.duration.should eq(0)
      @timeslot = FactoryGirl.create(:timeslot, start_time: Time.current, end_time: 75.minutes.from_now)
      @timeslot.duration.should eq(1.25)
      #1.should eq(2)
    end
  end
end
