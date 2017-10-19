require 'rails_helper'

RSpec.describe Comment do
  describe 'validations' do
    it { is_expected.to validate_presence_of :person_id }
    it { is_expected.to validate_presence_of :description }
  end

  describe 'the default scope' do
    let!(:first_comment) { create(:comment) }
    let!(:second_comment) { create(:comment) }

    it 'orders comments by newest to oldest' do
      expect(Comment.all).to eq([second_comment, first_comment])
    end
  end
end
