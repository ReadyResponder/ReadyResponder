require 'spec_helper'

describe Repair do
  it "has a valid factory" do
    expect(FactoryGirl.create(:repair)).to be_valid
  end

end
