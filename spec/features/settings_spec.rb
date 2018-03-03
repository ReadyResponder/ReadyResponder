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

  describe "get_integer" do
    it 'returns value in the setting if present' do 
      Setting.create(:key => 'EVENTS_COUNT', :value => 10, :category => 'Person', :status => 'Active', :name => 'upcoming_events_count')       
      expect(Setting.get_integer('EVENTS_COUNT', 5)).to eq 10
    end

    it 'returns fallback value if the setting is inactive' do 
      Setting.create(:key => 'EVENTS', :value => 10, :category => 'Person', :status => 'Inactive', :name => 'upcoming_events_count')       
      expect(Setting.get_integer('EVENTS', 5)).to eq 5
    end  

    it 'returns nil when the value cannot be converted to integer' do   
      Setting.create(:key => 'EVENTS', :value => '10asdfasf', :category => 'Person', :status => 'Inactive', :name => 'upcoming_events_count')          
      expect(Setting.get_integer('EVENTS')).to eq nil
    end  

    it 'returns fallback value if setting is not present' do      
      expect(Setting.get_integer('UNAVILABLE_EVENT', 5)).to eq 5
    end

    it 'returns nil when both setting and fallback value is not present' do      
      expect(Setting.get_integer('UNAVILABLE_EVENT')).to eq nil
    end    
  end
end
