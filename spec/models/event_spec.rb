require 'spec_helper'

describe Event do
  it "has a valid factory" do
    FactoryGirl.create(:event).should be_valid
  end
  it "is invalid without a description" do
    FactoryGirl.build(:event, description: nil).should_not be_valid
  end
  
  it "is invalid if end date is before start date" do
    FactoryGirl.build(:event, start_date: Date.today, end_date: Date.today - 10).should_not be_valid
  end
end
