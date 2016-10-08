require 'rails_helper'
#save_and_open_page
describe 'Access on timecard' do
  it "gets denied" do
    visit timecards_path
    expect(page).to have_content("You need to sign in")
    visit new_timecard_path
    expect(page).to have_content("You need to sign in")
    @sample_object = create(:timecard)
    visit url_for(@sample_object)
    expect(page).to have_content("You need to sign in")
  end
end

describe Timecard do
  before (:each) do
    somebody = create(:user)
    r = create(:role, name: "Editor")
    somebody.roles << r
    visit new_user_session_path
    fill_in 'user_email', :with => somebody.email
    fill_in 'user_password', :with => somebody.password
    click_on 'Sign in'
  end

  it "gets the index" do
    @sample_object = create(:timecard)
    visit timecards_path
    expect(page).to have_content("Home") # In the nav bar
    expect(page).to have_css('#sidebar')
    expect(page).to have_content("Listing Timecards")
    expect(page).to have_content(@sample_object.category)
  end
  it "visits a creation form" do
    @sample_object = create(:timecard)
    visit new_timecard_path
    expect(page).to have_content("Home")
    expect(page).to have_css('#sidebar')
    expect(page).to have_content('Category')
    expect(page).to have_content("New Timecard")
  end
  it "visits a display page" do
    @sample_object = create(:timecard)
    visit timecard_path(@sample_object)
    expect(page).to have_content("Home")
    expect(page).to have_css('#sidebar')
    expect(page).to have_content(@sample_object.category)
    expect(page).to have_content(@sample_object.intention)
  end
  it "visits a display page without actual times" do
    @sample_object = create(:timecard, intended_start_time: nil, intended_end_time: nil, actual_start_time: nil, actual_end_time: nil)
    visit timecard_path(@sample_object)
    expect(page).to have_content("Home")
    expect(page).to have_css('#sidebar')
    expect(page).to have_content(@sample_object.category)
    expect(page).to have_content(@sample_object.intention)
    visit timecards_path
    expect(page).to have_content("Home")
    visit person_path(@sample_object.person)
    expect(page).to have_content("Home")
  end
end
