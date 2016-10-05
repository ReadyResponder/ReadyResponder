require 'spec_helper'

describe Item do
  it "has a valid factory" do
    expect(create(:item)).to be_valid
  end

end
