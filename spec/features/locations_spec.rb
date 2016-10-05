require 'spec_helper'

describe "Locations" do
  describe " visit locations" do
    before (:each) do
      somebody = create(:user)
      r = create(:role, name: 'Editor')
      somebody.roles << r
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    
    #sign_me_in
    get_basic_editor_views('location',['name','category'])
  end
end
