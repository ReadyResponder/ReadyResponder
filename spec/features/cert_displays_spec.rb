require 'spec_helper'
#Don't use capybara (ie visit/have_content) and rspec matchers together  {response.status.should be(200)}

describe "Cert" do
  before  do
    somebody = create(:user)
    r = create(:role, name: 'Editor')
    somebody.roles << r
   
    visit new_user_session_path
    fill_in('user_email', :with => somebody.email)
    fill_in('user_password', :with => somebody.password)
    click_on 'Sign in'
  end
  describe "when not logged in" do
    it "should not display anything" do
      click_on 'Sign Out'
      visit certs_path
      expect(page).not_to have_css("div.navbar")
      expect(current_path).to eq(new_user_session_path)
      expect(page).not_to have_content("Listing")
      expect(page).to have_content('You need to sign in')
      visit new_cert_path
      expect(page).to have_content('You need to sign in')
      acert = create(:cert)
      visit edit_cert_path(acert)
      expect(page).to have_content('You need to sign in')
    end
  end
      
  describe "should display" do
   it "a list" do
      cert = create(:cert)
      person = cert.person
      
      visit certs_path
      expect(page).to have_content("Listing Certs")
      expect(page).to have_content("LIMS") # This is in the nav bar
      expect(page).to have_content("Active") # This is in the cert
      expect(page).to have_link(person.fullname)
      expect(page).to have_link(cert.course.name)
      click_on person.fullname
      expect(page).to have_content('CJ')
    end

    it "a new cert form with an issued date field" do
      a_person = create(:person)
      a_course = create(:course)
      visit new_cert_path
      expect(page).to have_content("Issued Date")
      select(a_person.fullname, :from => 'cert_person_id')
      select(a_course.name, :from => 'cert_course_id')
      
    end
    it 'should update a cert' do
      
    end
    it "should show a cert page" do
      cert = create(:cert)
      visit cert_path(cert)
      expect(page).to have_content("Status: Active")
      cert.status = 'Expired'
      cert.save
      visit cert_path(cert)
      expect(page).to have_content("Status: Expired")
    end
  end
end
