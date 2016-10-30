require 'rails_helper'

RSpec.describe Message, type: :model do
  it "has a valid factory" do
    expect(create(:message)).to be_valid
  end
end
