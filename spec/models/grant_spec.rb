require 'rails_helper'

RSpec.describe Grant do
  let!(:grant) { build :grant }

  describe :validations do

    describe 'name presence' do
      it 'is valid with name' do
        grant.save
        expect(grant.errors.full_messages).to_not include('Name can\'t be blank')
      end

      it 'is invalid without name' do
        grant.name = nil
        grant.save
        expect(grant.errors.full_messages).to include('Name can\'t be blank')
      end
    end

    describe 'description presence' do
      it 'is valid with description' do
        grant.save
        expect(grant.errors.full_messages).to_not include('Description can\'t be blank')
      end

      it 'is invalid without description' do
        grant.description = nil
        grant.save
        expect(grant.errors.full_messages).to include('Description can\'t be blank')
      end
    end

    describe 'start_date presence' do
      it 'is valid with start_date' do
        grant.save
        expect(grant.errors.full_messages).to_not include('Start date can\'t be blank')
      end

      it 'is invalid without start_date' do
        grant.start_date = nil
        grant.save
        expect(grant.errors.full_messages).to include('Start date can\'t be blank')
      end
    end

    describe 'end_date presence' do
      it 'is valid with end_date' do
        grant.save
        expect(grant.errors.full_messages).to_not include('End date can\'t be blank')
      end

      it 'is invalid without end_date' do
        grant.end_date = nil
        grant.save
        expect(grant.errors.full_messages).to include('End date can\'t be blank')
      end
    end

  end
end
