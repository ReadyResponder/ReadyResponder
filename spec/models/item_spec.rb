require 'spec_helper'

describe Item do
  it "has a valid factory" do
    FactoryGirl.create(:inspection).should be_valid
  end

end
