require 'rails_helper'

RSpec.describe Vendor do
  before(:each) do
    sign_in_as("Editor")
  end

  context "fill in complete form " do
    it "renders a success message" do
      visit new_vendor_path

      fill_in("Name", with: "Amazon")
      fill_in("Street", with: "Foo Bar Street")
      fill_in("City", with: "City")
      fill_in("Street", with: "WA")
      fill_in("Zipcode", with: "7777")
      click_button("Create Vendor")

      expect(page).to have_content("Vendor was successfully created")
    end
  end

  context "Forgets to fill in name" do
    it "renders an error message" do
      visit new_vendor_path

      fill_in("Street", with: "Foo Bar Street")
      fill_in("City", with: "City")
      fill_in("Street", with: "WA")
      fill_in("Zipcode", with: "7777")
      click_button("Create Vendor")

      expect(page).to have_content("Name can't be blank")
    end
  end
end
