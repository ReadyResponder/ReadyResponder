require 'rails_helper'

RSpec.describe 'Access on user' do
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

RSpec.describe "user" do
  before (:each) { sign_in_as('Manager') }

  it "gets the index" do
    @user = create(:user, lastname: "Doe")
    visit users_path
    expect(page).to have_content("Home") # In the nav bar
    within_table("users") do
      expect(page).to have_content("Users")
    end
    expect(page).to have_content("Doe")
    end
  it "visits an edit form" do
    @user = create(:user, lastname: "Doe")
    visit edit_user_path(@user)
    expect(page).to have_content("Home")
    expect(page).to have_css('#sidebar')
    expect(page).to have_field('user_lastname', with: "Doe")
    fill_in 'user_lastname', with: "Ford"
    click_on 'Update'
    expect(page).to have_content("Ford")
    expect(page).not_to have_content("Doe")
  end
  it "visits a display page" do
    @user = create(:user, lastname: "Doe")
    visit url_for(@user)
    expect(page).to have_content("Home")
    expect(page).to have_css('#sidebar')
    expect(page).to have_content('Doe')
  end
end
