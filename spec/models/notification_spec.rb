require 'rails_helper'

RSpec.describe Notification do
  describe 'associations' do
    it 'can belong to an event' do
      expect(subject).to belong_to(:event)
    end

    it 'has many recipients'
  end
end
