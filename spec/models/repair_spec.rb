require 'rails_helper'

RSpec.describe Repair do
  it "has a valid factory" do
    expect(create(:repair)).to be_valid
  end

end
