require 'spec_helper'

describe Inspection do
  let(:an_item)  { create(:item) }
  it "has a valid factory" do
    expect(create(:inspection)).to be_valid
    expect(create(:inspection, item: an_item)).to be_valid
  end

  context 'validations' do
    it { should validate_presence_of(:item) }
    it { should validate_presence_of(:inspection_date) }
  end
end
