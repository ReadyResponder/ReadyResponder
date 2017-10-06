require 'rails_helper'

RSpec.describe Comment do
  describe '.recent' do
    let!(:first_comment) { create(:comment) }
    let!(:second_comment) { create(:comment) }

    it 'orders comments by newest to oldest' do
      expect(Comment.recent).to eq([second_comment, first_comment])
    end
  end
end
