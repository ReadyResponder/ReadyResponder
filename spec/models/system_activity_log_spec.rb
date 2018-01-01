require 'rails_helper'

RSpec.describe SystemActivityLog, type: :model do
  it { is_expected.to validate_presence_of(:message) }
  it { is_expected.to validate_presence_of(:category) }
end
