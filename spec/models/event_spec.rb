require 'spec_helper'

describe Event do
  it "has a valid factory" do
    expect(FactoryGirl.create(:event)).to be_valid
  end
  it "is invalid without a title" do
    expect(FactoryGirl.build(:event, title: nil)).not_to be_valid
  end
  
  it "is invalid if end date is before start date" do
    expect(FactoryGirl.build(:event, start_time: Time.current, end_time: 10.days.ago)).not_to be_valid
  end

  it "is invalid if start_time is blank and status is completed" do
    expect(FactoryGirl.build(:event, status: "Completed", start_time: nil, end_time: 10.days.ago )).not_to be_valid
  end
  it "is invalid if end_time is blank and status is completed" do
    expect(FactoryGirl.build(:event, status: "Completed", start_time: Time.current, end_time: nil)).not_to be_valid
  end

  it "returns a correct manhours count" do
    #This factory creates a person and an event
    @timecard1 = FactoryGirl.create(:timecard, actual_start_time: Time.current, actual_end_time: 75.minutes.from_now)
    @event = @timecard1.event
    @person1 = @timecard1.person
    @timecard2 = FactoryGirl.create(:timecard, event: @event, actual_start_time: Time.current, actual_end_time: 60.minutes.from_now)
    @person2 = @timecard2.person
    expect(@event.timecards.count).to equal(2)
    expect(@event.manhours).to eq(2.25)
    #1.should eq(2)
  end
  it "creates an available timecard with actual times brought in from the event" do
    @person = FactoryGirl.create(:person)
    @event = FactoryGirl.create(:event, start_time: Time.current, end_time: 75.minutes.from_now, status: "Scheduled")
    @timecard = @event.schedule(@person, "Available")
    expect(@timecard.class.name).to eq("Timecard")
    expect(@timecard.intention).to eq("Available")
    expect(@timecard.intended_start_time).to eq(@event.start_time)
    expect(@timecard.intended_end_time).to eq(@event.end_time)
  end
  it "reports if it's ready to schedule" do
    @event = FactoryGirl.build(:event, start_time: nil, end_time: 75.minutes.from_now, status: "Scheduled")
    expect(@event.ready_to_schedule?("Available")).to eq(false)  #Need a start time
    @event = FactoryGirl.build(:event, start_time: Time.current, end_time: nil, status: "Scheduled")
    expect(@event.ready_to_schedule?("Worked")).to eq(false)  #Need an end time
    @event = FactoryGirl.build(:event, start_time: Time.current, end_time: 75.minutes.from_now, status: "Closed")
    expect(@event.ready_to_schedule?("Scheduled")).to eq(false)  #Never for a closed event
  end

  it "always fails" do
    #1.should eq(2)
  end
end
