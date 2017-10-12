# Look at specs/support/shared_contexts/rake.rb
# for instructions on how to add to this or similar
# specs
require 'rails_helper'

RSpec.describe 'timecards:mark_stale_as_error' do
  include_context 'rake'

  specify { expect(subject.prerequisites).to contain_exactly('environment') }

  context 'when no TIMECARD_MAXIMUM_HOURS is defined' do
    before(:example) do
      allow(Setting).to receive(:get) { nil }
    end
    
    it 'raises a Setting::MissingSettingError' do
      expect { subject.invoke }.to raise_error(Setting::MissingSettingError)
    end
  end

  context 'when TIMECARD_MAXIMUM_HOURS is defined and 2 open timecards exist' do
    before(:example) do
      allow(Setting).to receive(:get) { 10 }
      
      person = create(:person)
      @stale_timecard = create(:timecard, person: person, status: 'Incomplete',
                               start_time: 11.hours.ago, end_time: nil)
      @regular_timecard = create(:timecard, person: person, status: 'Incomplete',
                                 start_time: 2.hours.ago, end_time: nil)
    end

    it 'updates the status of the stale timecards to Error' do
      subject.invoke
      expect(Timecard.where(status: 'Error')).to contain_exactly(@stale_timecard)
    end
  end
end
