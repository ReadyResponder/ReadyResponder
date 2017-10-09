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
    aux = create(:department, shortname: "BAUX")
    cert = create(:department, shortname: "CERT")
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
    department1 = create(:department, :name => "dep1")
    department2 = create(:department, :name => "dep2")
    visit people_path
    find('.add-btn').click
    expect(page).to have_field("person_department_id", :with => "")
  end
end
