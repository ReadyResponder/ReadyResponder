require 'rails_helper'

RSpec.describe Vendor do
  before(:each) do
    sign_in_as("Editor")
  end

  it "a new vendor form with appropriate fields" do
    visit new_vendor_path

    fill_in("Name", with: "Amazon")
    click_button("Create Vendor")

    expect(page).to have_content("Vendor was successfully created")
    expect(Vendor.last.status).to eq("Active")
  end
end
