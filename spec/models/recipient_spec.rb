require 'rails_helper'

RSpec.describe Recipient, type: :model do
  it "has a valid factory" do
    expect(create(:recipient)).to be_valid
  end
end
