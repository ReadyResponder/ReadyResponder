require 'spec_helper'
#Don't use capybara (ie visit/have_content and       #response.status.should be(200)

describe "Cert" do
  describe "should display" do
   it "a list" do
      cert = FactoryGirl.create(:cert, status: 'Active')
      person = cert.person
      
      visit certs_path
      page.should have_content("Listing Certs")
      page.should have_content("LIMS") # This is in the nav bar
      page.should have_content("Active") # This is in the cert
      page.should have_link(person.fullname)
      page.should have_link(cert.name)
      #clink_link('
    end

    it "a new cert form with an issued date field" do
      visit new_cert_path
      page.should have_content("Issued Date")
    end

    it " a cert page" do
      cert = FactoryGirl.create(:cert, status: 'Active')
      visit cert_path(cert)
      page.should have_content("Status: Active")
      cert.status = 'Expired'
      cert.save
      visit cert_path(cert)
      page.should have_content("Status: Expired")
    end
  end
end
