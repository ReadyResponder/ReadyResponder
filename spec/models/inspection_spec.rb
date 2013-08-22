require 'spec_helper'

describe Inspection do
  an_example = FactoryGirl.create(:inspection)
  it "has a valid factory" do
    FactoryGirl.create(:inspection).should be_valid
  end

  #mail.subject.should eq("Cert expiring")
  #an_example.status.should eq("Active")
end
