require 'spec_helper'
#save_and_open_page
describe 'Access on user' do
  it "gets denied" do
    visit users_path
    page.should have_content("need to sign in")
    @user = FactoryGirl.create(:user)
    visit url_for(@user)
    page.should have_content("need to sign in")
    visit edit_user_path(@user)
    page.should have_content("need to sign in")
  end
end
describe "user" do
  before (:each) do
    somebody = FactoryGirl.create(:user)
    r = FactoryGirl.create(:role, name: "Manager")
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end

  it "gets the index" do
    @user = FactoryGirl.create(:user, lastname: "Doe")
    visit users_path
    page.should have_content("LIMS") # In the nav bar
    page.should have_css('#sidebar')
    page.should have_content("Listing Users")
    page.should have_content("Doe")
    end
  it "visits an edit form" do
    @user = FactoryGirl.create(:user, lastname: "Doe")
    visit edit_user_path(@user)
    page.should have_content("LIMS")
    page.should have_css('#sidebar')
    page.should have_field('user_lastname', :with => "Doe")
    fill_in 'user_lastname', :with => "Ford"
    click_on 'Update'
    page.should have_content("Ford")
    page.should_not have_content("Doe")
  end
  it "visits a display page" do
    @user = FactoryGirl.create(:user, lastname: "Doe")
    visit url_for(@user)
    page.should have_content("LIMS")
    page.should have_css('#sidebar')
    page.should have_content('Doe')
  end
end