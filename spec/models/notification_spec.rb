require 'rails_helper'

RSpec.describe Notification do
  describe 'associations' do
    it 'can belong to an event' do
      expect(subject).to belong_to(:event)
    end
  end
  describe 'validations' do
    context 'status' do
      it 'accepts a valid status' do
        notification = build(:notification, departments: [build(:department)])
        expect(notification).to be_valid
      end

      it 'rejects an invalid status' do
        allow_any_instance_of(Notification).to \
              receive(:notification_has_at_least_one_recipient).and_return(true)
        notification = build(:notification, status: 'fake_status')
        expect(notification).to_not be_valid
      end
    end
    context 'recipients' do
      it 'invalid when department is not selected' do
        notification = build(:notification)
        expect(notification).to_not be_valid
      end
      it 'valid when department is selected' do
        department = create(:department)
        notification = build(:notification, departments: [department])
        expect(notification).to be_valid
      end
    end
  end
end
