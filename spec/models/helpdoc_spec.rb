require 'spec_helper'

describe Helpdoc do
  it "has a valid factory" do
    FactoryGirl.create(:inspection).should be_valid
  end
end
