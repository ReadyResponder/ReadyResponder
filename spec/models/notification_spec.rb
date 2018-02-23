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
    context 'id code' do
      it 'accepts only unique id codes' do
        notification_one = create(:notification, departments: [build(:department)], id_code: 1)
        expect(notification_one).to be_valid
        notification_two = build(:notification, departments: [build(:department)], id_code: 1)
        expect{notification_two.save!}.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Id code has already been taken')
      end
      it 'allows blanks' do
        notification = build(:notification, departments: [build(:department)])
        notification.id_code = nil
        notification.save!
        expect(notification).to be_valid
      end
    end
  end
end
