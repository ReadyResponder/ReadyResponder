require 'rails_helper'

RSpec.describe "Settings" do
  describe " visit settings" do
    before (:each) { sign_in_as('Editor') }

    get_basic_editor_views('setting',['name', 'key', 'value'])
  end

  describe "active?" do
    it 'returns based on status' do
      expect(Setting.new(:status => 'Active').active?).to be_truthy
      expect(Setting.new(:status => 'Inactive').active?).not_to be_truthy
    end
  end

  describe "find_or_create_upcoming_events_setting" do
    it 'creates upcomins events setting with defaults' do      
      setting = Setting.find_or_create_upcoming_events_setting(:value => 5)

      expect(setting.status).to eq 'Active'
      expect(setting.value).to eq '5'
      expect(setting.category).to eq 'Person'
      expect(setting.name).to eq 'Upcoming events count'
    end
  end
end
