require 'rails_helper'

RSpec.describe Assignment, type: :model do
  before(:example) do
    Timecop.freeze
  end

  after(:example) do
    Timecop.return
  end

  it { is_expected.to belong_to(:person) }
  it { is_expected.to belong_to(:requirement) }

  it { is_expected.to delegate_method(:task).to(:requirement) }
  it { is_expected.to delegate_method(:event).to(:task) }

  it { is_expected.to validate_presence_of(:person) }

  context 'active scope' do
    it 'returns a chainable relation' do
      expect(described_class.active).to be_a_kind_of(ActiveRecord::Relation)
    end
    
    context 'given 3 assignments with different statuses' do
      let(:person) { create(:person) }
      let!(:new_assignment)       { create(:assignment, person: person,
                                           status: 'New') }
      let!(:active_assignment)    { create(:assignment, person: person,
                                           status: 'Active') }
      let!(:cancelled_assignment) { create(:assignment, person: person,
                                           status: 'Cancelled') }

      it 'only returns the ones with a status of New or Active' do
        expect(described_class.active).to contain_exactly(new_assignment,
                                                          active_assignment)
      end
    end
  end

  context 'for_time_span scope' do
    it 'returns a chainable relation' do
      expect(described_class.for_time_span(3.hours.ago..1.hour.ago)).to be_a_kind_of(
        ActiveRecord::Relation)
    end

    context 'given 3 overlapping assignments with different durations' do
      let(:person) { create(:person) }
      let!(:assignment_1) { create(:assignment, person: person,
                            start_time: 4.hours.ago, end_time: 2.hour.ago) } 
      let!(:assignment_2) { create(:assignment, person: person,
                            start_time: 4.hours.ago, end_time: 1.hour.ago) } 
      let!(:assignment_3) { create(:assignment, person: person,
                            start_time: 2.hours.ago, end_time: 1.hours.ago) } 

      it 'only returns the assignments that contain the given interval' do
        expect(described_class.for_time_span(2.hours.ago..1.hour.ago)).to contain_exactly(
          assignment_2, assignment_3)
      end
    end
  end
end
