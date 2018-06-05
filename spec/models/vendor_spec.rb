require "rails_helper"

RSpec.describe Vendor, type: :model do
  it "has a valid factory" do
    expect(create(:vendor)).to be_valid
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to have_many(:items) }
    it { is_expected.to_not allow_value("").for(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
