require 'rails_helper'

RSpec.describe Grant do
  before(:each) do
    sign_in_as('Manager')
  end

  context "NEW Grant" do
    before do
      visit new_grant_path
    end

    it "a new grant form with appropriate fields" do
      expect(page).to have_field('grant_name')
      expect(page).to have_field('grant_description')
      expect(page).to have_field('grant_start_date')
      expect(page).to have_field('grant_end_date')
    end

    it "create new grant" do
      fill_in('grant_name', :with => 'foo')
      fill_in('grant_description', :with => 'bar')
      fill_in('grant_start_date', :with => '10-10-2010')
      fill_in('grant_end_date', :with => '10-10-2012')
      click_button('Create Grant')

      expect(Grant.last.name).to eq('foo')
    end
  end

  context "EDIT Grant" do
    before do
      @grant = create(:grant)
      visit edit_grant_path(@grant)
    end

    it "edit page should have appropriate fields" do
      expect(page).to have_field('grant_name')
      expect(page).to have_field('grant_description')
      expect(page).to have_field('grant_start_date')
      expect(page).to have_field('grant_end_date')
    end

    it "successful edit should update data in grants table" do
      fill_in('grant_name', :with => 'foo update')
      click_button('Update Grant')

      expect(Grant.last.name).to eq('foo update')
    end
  end

end
