require 'rails_helper'

RSpec.describe "a user" do
  describe "in the reader role" do
    before (:each) { sign_in_as('Reader') }

    it "cannot edit certs" do
      acert = create(:cert)
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
      acert = create(:cert)
      visit certs_path
      click_on acert.person.fullname
      expect(page).to have_content(acert.person.fullname)
    end
  end
end
