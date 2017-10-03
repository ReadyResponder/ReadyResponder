require 'rails_helper'

RSpec.describe Grant do
  context "associations" do
    it { is_expected.to have_many(:items) }
  end

  it "has a valid factory" do
    expect(create(:grant)).to be_valid
  end
end
