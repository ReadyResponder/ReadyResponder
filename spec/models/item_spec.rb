require 'rails_helper'

RSpec.describe Item do
  context "associations" do
    it { is_expected.to belong_to(:grantor) }
    it { is_expected.to belong_to(:vendor) }
  end

  it "has a valid factory" do
    expect(create(:item)).to be_valid
  end
end
