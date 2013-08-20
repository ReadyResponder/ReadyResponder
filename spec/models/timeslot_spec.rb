require 'spec_helper'

describe Timeslot do
  before :each do
    @timeslot1 = FactoryGirl.create(:timeslot)
    @timeslot2 = FactoryGirl.create(:timeslot)   
  end
  describe "#new" do
    #@attendance.should be_an_instance_of Attendance
  end
end
