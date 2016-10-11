require 'rails_helper'

describe Notification do
  describe 'associations' do
    it 'can belong to an event' do
      expect(subject).to belong_to(:event)
    end

    it 'has many recipients'
  end

  describe 'validations' do
    context 'status' do
      it 'accepts a valid status' do
        notification = build(:notification, status: 'pending')
        expect(notification).to be_valid
      end

      it 'rejects an invalid status' do
        notification = build(:notification, status: 'fake_status')
        expect(notification).to_not be_valid
      end
    end


  end


end
