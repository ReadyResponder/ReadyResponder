require 'spec_helper'

describe "Channels" do
  before  do
    @channel = FactoryGirl.create(:channel)
    somebody = FactoryGirl.create(:user)
    r = FactoryGirl.create(:role, name: 'Editor')
    somebody.roles << r
   
    visit new_user_session_path
    fill_in('user_email', :with => somebody.email)
    fill_in('user_password', :with => somebody.password)
    click_on 'Sign in'
  end
  describe "channels" do
    it "index works" do
      visit channels_path
      page.should have_content("Listing Channels")
    end
  end
end
