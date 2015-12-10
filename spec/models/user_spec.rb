require 'spec_helper'

describe User do
  it "requires a username" do
    a_user = FactoryGirl.build(:user, username: nil)
    expect(a_user).not_to be_valid
  end
  
end
