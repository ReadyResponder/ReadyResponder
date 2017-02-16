require 'rails_helper'

RSpec.describe Phone do
  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:content) }

    describe 'content' do
      it 'is invalid if it has too many digits' do
        phone = build :phone, content: '+180055512120', status: 'Active'
        expect(phone).not_to be_valid
      end

      it 'is invalid if it has too few digits' do
        phone = build :phone, content: '+15551212', status: 'Active'
        expect(phone).not_to be_valid
      end

      it 'is invalid if it does not start with +1' do
        phone = build :phone, content: '18005551212', status: 'Active'
        expect(phone).not_to be_valid
      end

      it 'is valid if it is just right' do
        phone = build :phone, content: '+18005551212', status: 'Active'
        expect(phone).to be_valid
      end

    end
  end
end
