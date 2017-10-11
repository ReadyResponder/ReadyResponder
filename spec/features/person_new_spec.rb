require 'rails_helper'

RSpec.feature "On new person page" do
  before do
    somebody = create(:user)
    r = create(:role, name: 'Editor')
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end

  scenario "default department should be selected when there is only one active department", js: true do
    Department.destroy_all
    department = create(:department)
    visit people_path
    find('.add-btn').click
    expect(page).to have_field("person_department_id", :with => department.id)
  end

  scenario "department should be empty when there are more than one active department", js: true do
    Department.destroy_all
    create(:department, shortname: "BAUX")
    create(:department, shortname: "CERT")
    visit people_path
    find('.add-btn').click
    expect(page).to have_field("person_department_id", :with => "")
  end
end
