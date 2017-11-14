require "rails_helper"

RSpec.describe Vendor, type: :model do
  it "has a valid factory" do
    expect(create(:vendor)).to be_valid
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it "is not valid without a name" do
      subject.name = "testing"
      expect(subject).to be_valid
    end
  end
end
