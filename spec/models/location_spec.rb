require 'spec_helper'

describe Location do
  it "has a valid factory" do
    FactoryGirl.create(:location).should be_valid
  end

end
