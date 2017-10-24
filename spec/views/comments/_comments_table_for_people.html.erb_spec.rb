require 'rails_helper'

RSpec.describe 'comments/_comments_table_for_people', type: :view do
  context 'when there are one or more comments' do
    let(:comment) do
      double('comment',
        title: 'Some Title',
        description: 'Some Description'
      ).as_null_object
    end

    it 'renders comments' do
      render partial: 'comments/comments_table_for_people',
        locals: { comments: [ comment ] }

      expect(rendered).to include("Some Title")
      expect(rendered).to include("Some Description")
      expect(rendered).to_not include('No comments yet!')
    end
  end

  context 'when there are no comments' do
    it 'should render the no comments message' do
      render partial: 'comments/comments_table_for_people',
        locals: { comments: [] }

        expect(rendered).to include('No comments yet!')
    end
  end
end
