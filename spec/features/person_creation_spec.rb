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

  scenario "from the everybody people page" do
    visit everybody_people_path
    click_link "People"
    click_link "New Person"
    fill_in "First Name", with: "John"
    fill_in "Last Name", with: "Doe"
    fill_in "Date of birth", with: "1990-05-13"
    select "Active", from: "person_status" #"Status" also matches Channel status
    click_button "Create Person"
    expect(page).to have_content "Person was successfully created."
    expect(current_path).to eq everybody_people_path
  end

  scenario "person can not be created if start date is before application date" do
    visit everybody_people_path
    click_link "People"
    click_link "New Person"
    fill_in "First Name", with: "John"
    fill_in "Last Name", with: "Doe"
    fill_in "Date of birth", with: "1990-05-13"
    select "Active", from: "person_status"
    fill_in "person[application_date]", with: "1991-05-13"
    fill_in "person[start_date]", with: "1990-05-13"

    click_button "Create Person"

    expect(current_path).to eq(new_person_path)
  end

end
