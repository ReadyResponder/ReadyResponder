require 'rails_helper'

RSpec.describe Location do
  it "has a valid factory" do
    expect(create(:location)).to be_valid
  end

end
