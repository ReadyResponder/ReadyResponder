require 'rails_helper'

RSpec.describe Inspection do
  let(:an_item)  { create(:item) }
  it "has a valid factory" do
    expect(create(:inspection, item: an_item)).to be_valid
  end

  # mail.subject.should eq("Cert expiring")
  # an_example.status.should eq("Active")
end
