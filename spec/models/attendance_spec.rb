require 'spec_helper'

describe Attendance do
  before :each do
    @attendance = FactoryGirl.create(:attendance)   
  end
  describe "#new" do
    #@attendance.should be_an_instance_of Attendance
  end
end
