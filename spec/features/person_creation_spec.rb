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
    # Used `find` instead of select, as `select Department.first.id, from: "person_department_id"` raises "Ambiguous match" error
    find(:css, '#person_department_id > option:nth-child(2)').select_option
    click_button "Create Person"
    expect(page).to have_content "Person was successfully created."
    expect(current_path).to eq everybody_people_path
  end


  scenario "when user-entered start date is before the applicaton date" do
    visit everybody_people_path

    click_link "People"
    click_link "New Person"

    fill_in "First Name", with: "G.I."
    fill_in "Last Name", with: "Joe"
    select "Active", from: "person_status"

    fill_in "Start date", with: "2017-01-01"
    fill_in "Application date", with: "2017-12-01"

    click_button "Create Person"
    expect(page).to have_content "Start date cannot be before the application date"

    expect(page).not_to have_content "Person was sucessfully created"
  end
end
