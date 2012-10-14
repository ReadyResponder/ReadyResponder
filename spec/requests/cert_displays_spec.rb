require 'spec_helper'
#Don't use capybara (ie visit/have_content) and rspec matchers together  {response.status.should be(200)}

describe "Cert" do
  before  do
    somebody = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in('user_email', :with => somebody.email)
    fill_in('user_password', :with => somebody.password)
    click_on 'Sign in'
  end
  describe "not logged in" do
    it "should not display a listing" do
      click_on 'Sign Out'
      visit certs_path
      page.should have_content("LIMS") # This is in the nav bar
      page.should_not have_content("Listing")
      page.should have_content('You need to sign in')
      visit new_cert_path
      acert = FactoryGirl.create(:cert)
      page.should have_content('You need to sign in')
      visit edit_cert_path(acert)
      page.should have_content('You need to sign in')
    end
  end
      
  describe "should display" do
   it "a list" do
      cert = FactoryGirl.create(:cert)
      person = cert.person
      
      visit certs_path
      page.should have_content("Listing Certs")
      page.should have_content("LIMS") # This is in the nav bar
      page.should have_content("Active") # This is in the cert
      page.should have_link(person.fullname)
      page.should have_link(cert.course.name)
      click_on person.fullname
      page.should have_content('CJ')
    end

    it "a new cert form with an issued date field" do
      visit new_cert_path
      page.should have_content("Issued Date")
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
    end
  end
end
