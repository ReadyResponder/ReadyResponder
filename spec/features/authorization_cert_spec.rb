require 'spec_helper'
      #save_and_open_page
describe "a user" do
  describe "in the reader role" do
    before (:each) do
      person = FactoryGirl.create(:person, lastname: 'YesDoe')
      somebody = FactoryGirl.create(:user)
      r = FactoryGirl.create(:role, name: 'Reader')
      somebody.roles << r
      visit new_user_session_path
      fill_in 'user_email', :with => somebody.email
      fill_in 'user_password', :with => somebody.password
      click_on 'Sign in'
    end
    it "cannot edit certs" do
      acert = FactoryGirl.create(:cert)
      visit certs_path
      expect(page).not_to have_content('Edit') #Need to scope this, or it will fail on Edith
      expect(find('table#certs')).not_to have_button('Edit')
      visit cert_path(acert)
      expect(page).not_to have_content('Edit')
      visit edit_cert_path(acert)
      expect(page).to have_content("Access Denied")
    end
    it "cannot create a new cert" do
      visit certs_path
      expect(page).not_to have_content('New')
      visit new_cert_path
      expect(page).to have_content("Access Denied")
    end
    it "can read a cert" do
      acert = FactoryGirl.create(:cert)
      visit certs_path
      click_on acert.person.fullname
      expect(page).to have_content(acert.person.fullname)
    end
  end
end
