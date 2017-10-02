require 'rails_helper'

RSpec.describe Item do
  context "associations" do
    it { is_expected.to belong_to(:grant) }
  end

  it "has a valid factory" do
    expect(create(:item)).to be_valid
  end
end
