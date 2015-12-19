require 'spec_helper'

describe Location do
  it "has a valid factory" do
    expect(FactoryGirl.create(:location)).to be_valid
  end

end
