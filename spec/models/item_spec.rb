require 'rails_helper'

RSpec.describe Item do
  it { is_expected.to belong_to(:grantor) }
  it { is_expected.to have_many(:inspection_questions).through(:inspections) }

  it 'has a valid factory' do
    expect(create(:item)).to be_valid
  end
end
