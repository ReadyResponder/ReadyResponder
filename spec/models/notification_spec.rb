require 'rails_helper'

RSpec.describe Notification do
  describe 'associations' do
    it 'can belong to an event' do
      expect(subject).to belong_to(:event)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:subject) }
    it { is_expected.to validate_presence_of(:body) }
    it { is_expected.to validate_inclusion_of(:status).in_array(%w(pending active canceled complete expired)) }

    context 'channels' do
      it 'accepts a valid set of channels' do
        notification = build(:notification, channels: 'email text voice')
        expect(notification).to be_valid
      end

      it 'rejects an invalid set of channels' do
        notification = build(:notification, status: 'email carrier-pidgeon')
        expect(notification).to_not be_valid
      end
    end
  end
end
