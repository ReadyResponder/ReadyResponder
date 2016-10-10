require 'rails_helper'

RSpec.describe "Channels" do
  before (:each) do
    somebody = create(:user)
    r = create(:role, name: 'Editor')
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end
  
  get_basic_editor_views('channel',['category'])
end
