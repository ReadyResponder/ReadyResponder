require 'spec_helper'

describe Event do
  it "has a valid factory" do
    FactoryGirl.create(:event).should be_valid
  end
  it "is invalid without a description" do
    FactoryGirl.build(:event, description: nil).should_not be_valid
  end
  
  it "is invalid if end date is before start date" do
    FactoryGirl.build(:event, start_time: Date.today, end_time: Date.today - 10).should_not be_valid
  end

  it "returns a correct manhours count" do
    #This factory creates a person and an event
    @timeslot1 = FactoryGirl.create(:timeslot, actual_start_time: Time.current, actual_end_time: 75.minutes.from_now)
    @event = @timeslot1.event
    @person1 = @timeslot1.person
    @timeslot2 = FactoryGirl.create(:timeslot, event: @event, actual_start_time: Time.current, actual_end_time: 60.minutes.from_now)
    @person2 = @timeslot2.person
    @event.timeslots.count.should equal(2)
    @event.manhours.should eq(2.25)
    #1.should eq(2)
  end
end
