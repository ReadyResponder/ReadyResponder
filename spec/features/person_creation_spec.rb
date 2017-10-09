require 'rails_helper'

RSpec.feature "Users can create new people" do
  before do
    somebody = create(:user)
    r = create(:role, name: 'Editor')
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
    aux = create(:department, shortname: "BAUX")
    cert = create(:department, shortname: "CERT")
  end

  scenario "from the people page a.k.a all active", js: true do
    visit people_path
    find('.add-btn').click
    fill_in "First Name", with: "John"
    fill_in "Last Name", with: "Doe"
    fill_in "Date of birth", with: "1990-05-13"
    select "Active", from: "person_status" #"Status" also matches Channel status
    page.execute_script "window.scrollBy(0,1500)"
    click_button "Create Person"
    expect(page).to have_content "Person was successfully created."
    expect(current_path).to eq people_path
  end


  scenario "when user-entered start date is before the applicaton date", js: true do
    visit applicants_people_path
    find('.add-btn').click
    fill_in "First Name", with: "G.I."
    fill_in "Last Name", with: "Joe"
    select "Active", from: "person_status"
    fill_in "Start date", with: "2017-01-01"
    fill_in "Application date", with: "2017-12-01"
    page.execute_script "window.scrollBy(0,1500)"
    click_button "Create Person"
    expect(page).to have_content "Start date cannot be before the application date"
    expect(page).not_to have_content "Person was sucessfully created"
  end
end
