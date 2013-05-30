require 'spec_helper'

describe User do
  it "requires a username" do
    a_user = FactoryGirl.build(:user, username: nil)
    a_user.should_not be_valid
  end
  
end
