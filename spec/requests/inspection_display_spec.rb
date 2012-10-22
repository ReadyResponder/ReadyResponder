require 'spec_helper'
#Don't use capybara (ie visit/have_content) and rspec matchers together  {response.status.should be(200)}

describe "Inspection" do
  before  do
    somebody = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in('user_email', :with => somebody.email)
    fill_in('user_password', :with => somebody.password)
    click_on 'Sign in'
  end
  describe "when not logged in" do
    it "should not display a listing" do
      click_on 'Sign Out'
      visit inspections_path
      page.should have_content("LIMS") # This is in the nav bar
      page.should_not have_content("Listing")
      page.should have_content('You need to sign in')
      visit new_inspection_path
      page.should have_content('You need to sign in')
  #    an_inspection = FactoryGirl.create(:inspection)
  #    visit edit_inspection_path(an_inspection)
  #    page.should have_content('You need to sign in')
    end
  end
  describe "should have a form" do
    it "a new inspection form with a field with people listed" do
      a_person = FactoryGirl.create(:person)
      visit new_inspection_path
      page.should have_content(a_person.lastname.to_s)
    end
  end
  describe "should display" do
   it "a list" do
=begin
      an_inspection = FactoryGirl.create(:inspection)
      person = cert.person
      
      visit inspections_path
      page.should have_content("Listing Inspections")
      page.should have_content("LIMS") # This is in the nav bar
      page.should have_content("Active") # This is in the cert
      page.should have_link(person.fullname)
      page.should have_link(cert.course.name)
      click_on person.fullname
      page.should have_content('CJ')
    end

    it 'should update a cert' do
      
    end
    it "a cert page" do
      cert = FactoryGirl.create(:cert)
      visit cert_path(cert)
      page.should have_content("Status: Active")
      cert.status = 'Expired'
      cert.save
      visit cert_path(cert)
      page.should have_content("Status: Expired")
=end
    end
  end
end
