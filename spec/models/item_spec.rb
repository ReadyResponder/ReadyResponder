require 'rails_helper'

RSpec.describe Item do
  it "has a valid factory" do
    expect(create(:item)).to be_valid
  end

  it 'has a status of OOS if condition is OOS' do
    item = build :item, condition: 'Out of Service', status: 'Unassigned'
    expect(item.status).to eq('Out of Service')
  end

  it 'has a status of Unassigned if condition is Available and status is Unassigned' do
    item = build :item, condition: 'Available', status: 'Unassigned'
    expect(item.status).to eq('Unassigned')
  end

end
