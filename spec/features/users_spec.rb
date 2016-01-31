require 'spec_helper'
#save_and_open_page
describe 'Access on user' do
  it "gets denied when not logged in" do
    visit users_path
    expect(page).to have_content("need to sign in")
    @user = create(:user)
    visit url_for(@user)
    expect(page).to have_content("need to sign in")
    visit edit_user_path(@user)
    expect(page).to have_content("need to sign in")
  end
end
describe "user" do
  before (:each) do
    somebody = create(:user)
    r = create(:role, name: "Manager")
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end

  it "gets the index" do
    @user = create(:user, lastname: "Doe")
    visit users_path
    expect(page).to have_content("LIMS") # In the nav bar
    expect(page).to have_css('#sidebar')
    within_table("users") do
      expect(page).to have_content("Users")
    end
    expect(page).to have_content("Doe")
    end
  it "visits an edit form" do
    @user = create(:user, lastname: "Doe")
    visit edit_user_path(@user)
    expect(page).to have_content("LIMS")
    expect(page).to have_css('#sidebar')
    expect(page).to have_field('user_lastname', :with => "Doe")
    fill_in 'user_lastname', :with => "Ford"
    click_on 'Update'
    expect(page).to have_content("Ford")
    expect(page).not_to have_content("Doe")
  end
  it "visits a display page" do
    @user = create(:user, lastname: "Doe")
    visit url_for(@user)
    expect(page).to have_content("LIMS")
    expect(page).to have_css('#sidebar')
    expect(page).to have_content('Doe')
  end
end