require 'rails_helper'

RSpec.describe Helpdoc do
  it "has a valid factory" do
    expect(create(:helpdoc)).to be_valid
  end
end
