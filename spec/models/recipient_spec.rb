require 'rails_helper'

RSpec.describe Recipient, type: :model do
  it "has a mostly valid factory" do
    allow_any_instance_of(Notification).to \
                receive(:notification_has_at_least_one_recipient).and_return(true)
    expect(create(:recipient)).to be_valid
  end
end
