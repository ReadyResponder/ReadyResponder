require 'spec_helper'

describe Item do
  it "has a valid factory" do
    expect(FactoryGirl.create(:inspection)).to be_valid
  end

end
